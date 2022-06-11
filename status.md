This is a bootleg progress tracker for KSY for Halo CE tags. If people start using this project, I'll convert this into a real GitHub issue.

Statuses:
- **Done**: Good with no outstanding TODOs.
- **Good**: Loads with all fields properly represented. Some outstanding non-functional TODOs.
- **Loads**: KSY produces a functional reader, but some fields are not properly represented (e.g. `u8` instead of named bitfield).
- **Blocked**: Kaitai Struct Compiler needs a feature added to support something.
- *Blank*: Not started yet.

| Tag Group | Status | Notes |
|-----------|--------|-------|
| HEADER | Loads | `flags` uses `u8` instead of bitfield |
| actor | Loads | `flags` uses `u4` instead of bitfield. Duplicates `bounds("f4")`, `vector2d("f4le")` |
| actor_variant | Loads | `flags` uses `u4` instead of bitfield |
| antenna |||
| biped ||
| bitmap |||
| camera_track |||
| color_table |||
| continuous_damage_effect |||
| contrail ||
| damage_effect |||
| decal |||
| dialogue ||
| detail_object_collection |||
| device ||
| device_control |||
| device_light_fixture |||
| device_machine ||
| effect |||
| equipment |||
| flag ||
| fog |||
| font |||
| garbage |||
| gbxmodel |||
| globals |||
| glow ||
| grenade_hud_interface |||
| hud_globals ||
| hud_message_text |||
| hud_number |||
| input_device_defaults |||
| item ||
| item_collection |||
| lens_flare |||
| light |||
| light_volume |||
| lightning |||
| material_effects |||
| meter |||
| model ||
| model_animations |||
| model_collision_geometry |||
| multiplayer_scenario_description |||
| object ||
| particle |||
| particle_system |||
| physics |||
| placeholder |||
| point_physics |||
| preferences_network_game |||
| projectile ||
| scenario |||
| scenario_structure_bsp |||
| scenery ||
| sound ||
| sound_environment |||
| sound_looping |||
| sound_scenery |||
| spheroid |||
| shader |||
| shader_transparent_chicago |||
| shader_transparent_chicago_extended |||
| shader_transparent_generic |||
| shader_environment ||
| shader_transparent_glass |||
| shader_transparent_meter |||
| shader_model ||
| shader_transparent_plasma |||
| shader_transparent_water |||
| sky ||
| string_list |||
| tag_collection |||
| ui_widget_collection |||
| ui_widget_definition |||
| unicode_string_list ||
| unit |||
| unit_hud_interface |||
| vehicle |||
| virtual_keyboard |||
| weapon |||
| weapon_hud_interface |||
| weather_particle_system |||
| wind | Good | Duplicates `bounds("f4")` |