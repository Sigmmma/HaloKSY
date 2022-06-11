from hashlib import md5
from importlib import import_module
from pathlib import Path
from construct import Struct

import pytest

# Mapping of Construct struct -> test resource filename
# TODO need to bundle these and provide a download from somewhere
STRUCT_RESOURCES = (
	('blam', 'blam.sav'),
	('savegame', 'savegame.bin'),
	('actor', 'hunter.actor'),
	('actor_variant', 'elite commander energy sword.actor_variant'),
	('wind', 'multiplayer.wind'),
)

@pytest.mark.parametrize('struct_name,resource_name', STRUCT_RESOURCES)
def test_struct_rw_hash(struct_name: str, resource_name: str):
	"""Ensures files come out of structs the same as they went in.

	Loads a test resource into a struct, writes it back out, then does a basic
	hash on the input and output to ensure the file was unchanged.

	This helps catch improper or missing fields in definitions.
	This helps catch syntax issues with Kaitai's Construct compiler.
	This DOES NOT catch things like incorrect endianness.
	"""

	# Struct name always matches struct's py file name
	module = import_module(f'structs.{struct_name}')
	struct: Struct = getattr(module, struct_name)

	resource_path = Path('resources', resource_name)
	with open(resource_path, 'rb') as resource_file:
		in_hash = md5(resource_file.read())

	parsed = struct.parse_file(resource_path)
	out_hash = md5(struct.build(parsed))

	assert in_hash.hexdigest() == out_hash.hexdigest()
