from pathlib import Path

import pytest
import yaml

ksy_files = dict()
for path in Path('../h1').rglob('*.ksy'):
	with open(path) as yaml_file:
		ksy_files[path.stem] = yaml.safe_load(yaml_file)

# Passing in just the filename improves test failure reporting.
# If we pass the data in directly, pytest will print the whole data dict on test
# failure, which makes debugging harder.
@pytest.mark.parametrize('filename', ksy_files.keys())
def test_static_ksy(filename):
	"""Ensures static data is present in all ksy files"""

	ksy = ksy_files[filename]
	meta = ksy.get('meta')
	assert meta.get('application') == 'Halo Custom Edition'
	assert meta.get('license')     == 'GPL-3.0-only'
	assert 'Gearbox Halo CE' in ksy.get('doc')

	if filename != 'common':
		xref = meta.get('xref')
		assert xref.get('tag_id') or xref.get('filename')
		assert 'c20.reclaimers.net' in ksy.get('doc-ref')

	if filename not in ('blam', 'common', 'savegame'):
		assert meta.get('id')             == filename
		assert meta.get('file-extension') == filename

		xref = meta.get('xref')
		assert xref.get('filename') is None
		assert xref.get('tag_id') and len(xref.get('tag_id')) == 4

