from pathlib import Path
from typing import Callable

import pytest
import yaml

BLOCK_TYPES = ['block', 'tag_dependency']

ksy_files: 'dict[str,dict]' = dict()
for path in Path('../h1').rglob('*.ksy'):
	with open(path) as yaml_file:
		ksy_files[path.stem] = {
			'path': path,
			'ksy': yaml.safe_load(yaml_file),
		}

# Define helpers up front so pytest can use them for parametrization
def is_common(filename: str):
	return 'common' in str(ksy_files[filename]['path'])

def is_top_level(filename: str):
	return not is_common(filename)

def is_file(filename: str):
	return filename in ('blam', 'savegame')

def is_tag(filename: str):
	return is_top_level(filename) and not is_file(filename)

def ksy_filter(filter: Callable[[str],bool]):
	return [f for f in ksy_files.keys() if filter(f)]

# Passing in just the filename improves test report readability.
# If we pass the data in directly, pytest will print the whole data dict for
# each test, which makes debugging much harder.
@pytest.mark.parametrize('filename', ksy_files.keys())
def test_static_meta(filename: str):
	'Ensures static data is present in all ksy files'

	ksy: dict = ksy_files[filename]['ksy']
	meta: dict = ksy.get('meta')
	assert meta

	assert meta.get('application') == 'Halo Custom Edition'
	assert meta.get('license')     == 'GPL-3.0-only'
	assert 'Gearbox Halo CE' in ksy.get('doc')

	if is_top_level(filename):
		assert meta.get('id') == filename
		assert 'c20.reclaimers.net' in ksy.get('doc-ref')

		xref: dict = meta.get('xref')
		assert xref

		if is_file(filename):
			assert xref.get('filename')
			assert xref.get('tag_group') is None

		if is_tag(filename):
			assert meta.get('file-extension') == filename
			assert xref.get('filename') is None
			assert xref.get('tag_group') and len(xref.get('tag_group')) == 4

	if is_common(filename):
		assert meta.get('endian') == 'be'

@pytest.mark.parametrize('filename', ksy_filter(is_common))
def test_common_block_fields(filename: str):
	'''Ensures blocks are not used in common types.

	Since block data appears at the end of tag data, block fields should not
	be used in common files (which are used as parts of the whole tag).
	'''

	seq: list[dict] = ksy_files[filename]['ksy']['seq']
	block_fields = [s for s in seq if s.get('type') in BLOCK_TYPES]

	assert block_fields == []

