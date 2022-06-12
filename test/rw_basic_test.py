from hashlib import md5
from importlib import import_module
from math import radians
from pathlib import Path
from typing import Any
from construct import Struct

import pytest

# Mapping of Construct struct -> test resource filename, along with
# some known field values to check for correctness.
# TODO need to bundle these and provide a download from somewhere
STRUCT_RESOURCES: 'tuple[str,str,dict[str,Any]]' = (
	('blam', 'blam.sav', {
		'player_details.name': 'Mimic',
		'controls.keyboard_binds.apostrophe': 'throw_grenade',
		'network_settings.connection_type': 't1_lan',
	}),
	('savegame', 'savegame.bin', {
		'last_difficulty': 'normal',
		'last_played_scenario': 'b30_evolved',
	}),
	('actor', 'hunter.actor', {
		'combat_perception_time': 0.6,
		'guard_position_time.min': 8,
		'standing_gun_offset.j': -0.23,
	}),
	('actor_variant', 'elite commander energy sword.actor_variant', {
		'actor_definition_path': 'characters\\elite\\elite commander\\elite commander',
		'berserk_melee_range': 16,
		'change_colors_block.0.upper_bound.green': 0.239216,
	}),
	('wind', 'multiplayer.wind', {
		'damping': 0.7,
		'variation_area.yaw': radians(50),
		'velocity.min': 0.6,
	}),
)

@pytest.mark.parametrize('struct_name,resource_name',
	((s,r) for s,r,_ in STRUCT_RESOURCES)
)
def test_struct_rw_hash(struct_name: str, resource_name: str):
	'''Ensures files come out of structs the same as they went in.

	Loads a test resource into a struct, writes it back out, then does a basic
	hash on the input and output to ensure the file was unchanged.

	This helps catch improper or missing fields in definitions.
	This helps catch syntax issues with Kaitai's Construct compiler.
	This DOES NOT catch things like incorrect endianness.
	'''

	struct = get_struct(struct_name)
	resource_path = Path('resources', resource_name)
	with open(resource_path, 'rb') as resource_file:
		in_hash = md5(resource_file.read())

	parsed = struct.parse_file(resource_path)
	out_hash = md5(struct.build(parsed))

	assert in_hash.hexdigest() == out_hash.hexdigest()

@pytest.mark.parametrize('struct_name,resource_name,checks', STRUCT_RESOURCES)
def test_check_values(struct_name: str, resource_name: str, checks: 'dict[str,Any]'):
	'''
	Spot-checks individual values within files to ensure things
	like endianness are set properly.
	'''

	struct = get_struct(struct_name)
	parsed = struct.parse_file(Path('resources', resource_name))

	# Always check header matches tag group
	if struct_name not in ['blam', 'savegame']:
		checks['header.group'] = struct_name

	# Drill into nested values, where necessary
	for field_path, expected_value in checks.items():
		got_value = parsed
		for part in field_path.split('.'):
			if part.isnumeric():
				got_value = got_value[int(part)]
			else:
				got_value = getattr(got_value, part)

		if isinstance(expected_value, float):
			assert got_value == pytest.approx(expected_value, 1e-6)
		else:
			assert got_value == expected_value

def get_struct(name: str) -> Struct:
	# Struct name always matches struct's py file name
	module = import_module(f'structs.{name}')
	return getattr(module, name)
