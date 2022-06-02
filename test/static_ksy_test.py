from pathlib import Path

import pytest
import yaml

ksy_files = dict()
for path in Path('../h1').rglob('*.ksy'):
	with open(path) as yaml_file:
		ksy_files[path.stem] = {
			'path': path,
			'ksy': yaml.safe_load(yaml_file),
		}

# Passing in just the filename improves test failure reporting.
# If we pass the data in directly, pytest will print the whole data dict on test
# failure, which makes debugging harder.
@pytest.mark.parametrize('filename', ksy_files.keys())
def test_static_ksy(filename):
	"""Ensures static data is present in all ksy files"""

	fileinfo = ksy_files[filename]
	ksy = fileinfo['ksy']

	meta = ksy.get('meta')
	assert meta

	assert meta.get('application') == 'Halo Custom Edition'
	assert meta.get('license')     == 'GPL-3.0-only'
	assert 'Gearbox Halo CE' in ksy.get('doc')

	if is_top_level(filename):
		assert meta.get('id') == filename
		assert 'c20.reclaimers.net' in ksy.get('doc-ref')

		xref = meta.get('xref')
		assert xref

		if is_file(filename):
			assert xref.get('filename')
			assert xref.get('tag_group') is None

		if is_tag(filename):
			assert meta.get('file-extension') == filename
			assert xref.get('filename') is None
			assert xref.get('tag_group') and len(xref.get('tag_group')) == 4

def is_top_level(filename):
	return 'common' not in str(ksy_files[filename]['path'])

def is_file(filename):
	return filename in ('blam', 'savegame')

def is_tag(filename):
	return is_top_level(filename) and not is_file(filename)

