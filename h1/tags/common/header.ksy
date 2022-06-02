meta:
  id: header
  application: Halo Custom Edition
  license: GPL-3.0-only
  endian: be
doc: Gearbox Halo CE common header shared by all tags
# TODO doc-ref
seq:
  - id: padding
    size: 36
  - id: group
    type: u4
    enum: tag_group
  - id: checksum
    type: u4
    # default 0
  - id: header_size
    type: u4
    # default 64
  - id: flags
    type: u8 # 64 bit bitfield
    #type: b64
    #repeat: expr
    #repeat-expr: 64
  - id: version
    type: u2
    # default 1
  - id: integrity0
    type: u1
  - id: integrity1
    type: u1
  - id: engine_id
    type: u4
    enum: engine_id
enums:
  tag_group:
    # The -orig-id string is actually a 4 byte unsigned int encoded to an ASCII
    # string. That's where these strange enum values come from.
    # value = '0x' + ''.join('{:X}'.format(ord(char)) for char in name)
    0x61637472:
      id: actor
      -orig-id: 'actr'
    0x61637476:
      id: actor_variant
      -orig-id: 'actv'
    0x616E7421:
      id: antenna
      -orig-id: 'ant!'
    0x62697064:
      id: biped
      -orig-id: 'bipd'
    0x6269746D:
      id: bitmap
      -orig-id: 'bitm'
    0x7472616B:
      id: camera_track
      -orig-id: 'trak'
    0x636F6C6F:
      id: color_table
      -orig-id: 'colo'
    0x63646D67:
      id: continuous_damage_effect
      -orig-id: 'cdmg'
    0x636F6E74:
      id: contrail
      -orig-id: 'cont'
    0x6A707421:
      id: damage_effect
      -orig-id: 'jpt!'
    0x64656361:
      id: decal
      -orig-id: 'deca'
    0x75646C67:
      id: dialogue
      -orig-id: 'udlg'
    0x646F6263:
      id: detail_object_collection
      -orig-id: 'dobc'
    0x64657669:
      id: device
      -orig-id: 'devi'
    0x6374726C:
      id: device_control
      -orig-id: 'ctrl'
    0x6C696669:
      id: device_light_fixture
      -orig-id: 'lifi'
    0x6D616368:
      id: device_machine
      -orig-id: 'mach'
    0x65666665:
      id: effect
      -orig-id: 'effe'
    0x65716970:
      id: equipment
      -orig-id: 'eqip'
    0x666C6167:
      id: flag
      -orig-id: 'flag'
    0x666F6720:
      id: fog
      -orig-id: 'fog '
    0x666F6E74:
      id: font
      -orig-id: 'font'
    0x67617262:
      id: garbage
      -orig-id: 'garb'
    0x6D6F6432:
      id: gbxmodel
      -orig-id: 'mod2'
    0x6D617467:
      id: globals
      -orig-id: 'matg'
    0x676C7721:
      id: glow
      -orig-id: 'glw!'
    0x67726869:
      id: grenade_hud_interface
      -orig-id: 'grhi'
    0x68756467:
      id: hud_globals
      -orig-id: 'hudg'
    0x686D7420:
      id: hud_message_text
      -orig-id: 'hmt '
    0x68756423:
      id: hud_number
      -orig-id: 'hud#'
    0x64657663:
      id: input_device_defaults
      -orig-id: 'devc'
    0x6974656D:
      id: item
      -orig-id: 'item'
    0x69746D63:
      id: item_collection
      -orig-id: 'itmc'
    0x6C656E73:
      id: lens_flare
      -orig-id: 'lens'
    0x6C696768:
      id: light
      -orig-id: 'ligh'
    0x6D677332:
      id: light_volume
      -orig-id: 'mgs2'
    0x656C6563:
      id: lightning
      -orig-id: 'elec'
    0x666F6F74:
      id: material_effects
      -orig-id: 'foot'
    0x6D657472:
      id: meter
      -orig-id: 'metr'
    0x6D6F6465:
      id: model
      -orig-id: 'mode'
    0x616E7472:
      id: model_animations
      -orig-id: 'antr'
    0x636F6C6C:
      id: model_collision_geometry
      -orig-id: 'coll'
    0x6D706C79:
      id: multiplayer_scenario_description
      -orig-id: 'mply'
    0x6F626A65:
      id: object
      -orig-id: 'obje'
    0x70617274:
      id: particle
      -orig-id: 'part'
    0x7063746C:
      id: particle_system
      -orig-id: 'pctl'
    0x70687973:
      id: physics
      -orig-id: 'phys'
    0x706C6163:
      id: placeholder
      -orig-id: 'plac'
    0x70706879:
      id: point_physics
      -orig-id: 'pphy'
    0x6E677072:
      id: preferences_network_game
      -orig-id: 'ngpr'
    0x70726F6A:
      id: projectile
      -orig-id: 'proj'
    0x73636E72:
      id: scenario
      -orig-id: 'scnr'
    0x73627370:
      id: scenario_structure_bsp
      -orig-id: 'sbsp'
    0x7363656E:
      id: scenery
      -orig-id: 'scen'
    0x736E6421:
      id: sound
      -orig-id: 'snd!'
    0x736E6465:
      id: sound_environment
      -orig-id: 'snde'
    0x6C736E64:
      id: sound_looping
      -orig-id: 'lsnd'
    0x73736365:
      id: sound_scenery
      -orig-id: 'ssce'
    0x626F6F6D:
      id: spheroid
      -orig-id: 'boom'
    0x73686472:
      id: shader
      -orig-id: 'shdr'
    0x73636869:
      id: shader_transparent_chicago
      -orig-id: 'schi'
    0x73636578:
      id: shader_transparent_chicago_extended
      -orig-id: 'scex'
    0x736F7472:
      id: shader_transparent_generic
      -orig-id: 'sotr'
    0x73656E76:
      id: shader_environment
      -orig-id: 'senv'
    0x73676C61:
      id: shader_transparent_glass
      -orig-id: 'sgla'
    0x736D6574:
      id: shader_transparent_meter
      -orig-id: 'smet'
    0x736F736F:
      id: shader_model
      -orig-id: 'soso'
    0x73706C61:
      id: shader_transparent_plasma
      -orig-id: 'spla'
    0x73776174:
      id: shader_transparent_water
      -orig-id: 'swat'
    0x736B7920:
      id: sky
      -orig-id: 'sky '
    0x73747223:
      id: string_list
      -orig-id: 'str#'
    0x74616763:
      id: tag_collection
      -orig-id: 'tagc'
    0x536F756C:
      id: ui_widget_collection
      -orig-id: 'Soul'
    0x44654C61:
      id: ui_widget_definition
      -orig-id: 'DeLa'
    0x75737472:
      id: unicode_string_list
      -orig-id: 'ustr'
    0x756E6974:
      id: unit
      -orig-id: 'unit'
    0x756E6869:
      id: unit_hud_interface
      -orig-id: 'unhi'
    0x76656869:
      id: vehicle
      -orig-id: 'vehi'
    0x76636B79:
      id: virtual_keyboard
      -orig-id: 'vcky'
    0x77656170:
      id: weapon
      -orig-id: 'weap'
    0x77706869:
      id: weapon_hud_interface
      -orig-id: 'wphi'
    0x7261696E:
      id: weather_particle_system
      -orig-id: 'rain'
    0x77696E64:
      id: wind
      -orig-id: 'wind'
  engine_id:
    # Same ascii string -> code trick used here
    0x626C616D: blam
