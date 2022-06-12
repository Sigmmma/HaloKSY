meta:
  id: actor
  application: Halo Custom Edition
  file-extension: actor
  xref:
    tag_group: actr
  license: GPL-3.0-only
  endian: be
  imports:
    #- common/bounds
    - common/header
    - common/tag_dependency
    - common/vector2d
    - common/vector3d
doc: |
  Gearbox Halo CE actor tag

  Defines basic AI behaviour. Can be futher customized using the
  [actor_variant][] tag.
doc-ref: https://c20.reclaimers.net/h1/tags/actor/
seq:
  - id: header
    type: header
  - id: flags # TODO bitfield ActorFlags
    type: u4
  - id: more_flags # TODO bitfield ActorMoreFlags
    type: u4
  - id: padding01
    size: 12
  - id: type
    type: u2
    enum: actor_type
  - id: padding02
    size: 2
  - id: max_vision_distance
    type: f4
    doc: World Units
  - id: central_vision_angle
    type: f4
  - id: max_vision_angle
    type: f4
  - id: padding03
    size: 4
  - id: peripheral_vision_angle
    type: f4
  - id: peripheral_distance
    type: f4
    doc: World Units
  - id: padding04
    size: 4
  - id: standing_gun_offset
    type: vector3d
  - id: crouching_gun_offset
    type: vector3d
  - id: hearing_distance
    type: f4
    doc: World Units
  - id: notice_projectile_chance
    type: f4
    doc: Range[0, 1]
  - id: notice_vehicle_chance
    type: f4
    doc: Range[0, 1]
  - id: padding05
    size: 8
  - id: combat_perception_time
    type: f4
    doc: Seconds
  - id: guard_perception_time
    type: f4
    doc: Seconds
  - id: non_combat_perception_time
    type: f4
    doc: Seconds
  - id: inverse_combat_perception_time
    type: f4le
    doc: cache_only # TODO signal this in name somehow?
  - id: inverse_guard_perception_time
    type: f4le
    doc: cache_only # TODO signal this in name somehow?
  - id: inverse_non_combat_perception_time
    type: f4le
    doc: cache_only # TODO signal this in name somehow?
  - id: padding06
    size: 8
  - id: dive_into_cover_chance
    type: f4
    doc: Range[0, 1]
  - id: emerge_from_cover_chance
    type: f4
    doc: Range[0, 1]
  - id: dive_from_grenade_chance
    type: f4
    doc: Range[0, 1]
  - id: pathfinding_radius
    type: f4
    doc: World Units
  - id: glass_ignorance_chance
    type: f4
    doc: Range[0, 1]
  - id: stationary_movement_dist
    type: f4
    doc: World Units
  - id: free_flying_sidestep
    type: f4
    doc: World Units
  - id: begin_moving_angle
    type: f4
  - id: cosine_begin_moving_angle
    type: f4le
    doc: cache_only # TODO signal this in name somehow?
  - id: maximum_aiming_deviation
    type: vector2d
  - id: maximum_looking_deviation
    type: vector2d
  - id: noncombat_look_delta_l
    type: f4
  - id: noncombat_look_delta_r
    type: f4
  - id: combat_look_delta_l
    type: f4
  - id: combat_look_delta_r
    type: f4
  - id: idle_aiming_range
    type: vector2d
  - id: idle_looking_range
    type: vector2d
  - id: event_look_time_modifier
    #type: bounds("f4")
    type: bounds
  - id: noncombat_idle_facing
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: noncombat_idle_aiming
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: noncombat_idle_looking
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: guard_idle_facing
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: guard_idle_aiming
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: guard_idle_looking
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: combat_idle_facing
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: combat_idle_aiming
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: combat_idle_looking
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: padding07
    size: 8
  - id: cosine_maximum_aiming_deviation
    type: vector2dle
    doc: cache_only # TODO signal this in name somehow?
  - id: cosine_maximum_looking_deviation
    type: vector2dle
    doc: cache_only # TODO signal this in name somehow?
  - id: do_not_use_1
    type: tag_dependency
    doc: weapon, unused
  - id: padding08
    size: 268
  - id: do_not_use_2
    type: tag_dependency
    doc: projectile, unused
  - id: unreachable_danger_trigger
    type: u2
    enum: actor_unreachable_danger_trigger
  - id: vehicle_danger_trigger
    type: u2
    enum: actor_unreachable_danger_trigger
  - id: player_danger_trigger
    type: u2
    enum: actor_unreachable_danger_trigger
  - id: padding09
    size: 2
  - id: danger_trigger_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: friends_killed_trigger
    type: u2
  - id: friends_retreating_trigger
    type: u2
  - id: padding10
    size: 12
  - id: retreat_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: padding11
    size: 8
  - id: cowering_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: friend_killed_panic_chance
    type: f4
    doc: Range[0, 1]
  - id: leader_type
    type: u2
    enum: actor_type
  - id: padding12
    size: 2
  - id: leader_killed_panic_chance
    type: f4
    doc: Range[0, 1]
  - id: panic_damage_threshold
    type: f4
    doc: Range[0, 1]
  - id: surprise_distance
    type: f4
    doc: World Units
  - id: padding13
    size: 28
  - id: hide_behind_cover_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: hide_target_not_visible_time
    type: f4
    doc: Seconds
  - id: hide_shield_fraction
    type: f4
    doc: Range[0, 1]
  - id: attack_shield_fraction
    type: f4
    doc: Range[0, 1]
  - id: pursue_shield_fraction
    type: f4
    doc: Range[0, 1]
  - id: padding14
    size: 16
  - id: defensive_crouch_type
    type: u2
    enum: actor_defensive_crouch_type
  - id: padding15
    size: 2
  - id: attacking_crouch_threshold
    type: f4
  - id: defending_crouch_threshold
    type: f4
  - id: min_stand_time
    type: f4
    doc: Seconds
  - id: min_crouch_time
    type: f4
    doc: Seconds
  - id: defending_hide_time_modifier
    type: f4
  - id: attacking_evasion_threshold
    type: f4
  - id: defending_evasion_threshold
    type: f4
  - id: evasion_seek_cover_chance
    type: f4
    doc: Range[0, 1]
  - id: evasion_delay_time
    type: f4
    doc: Seconds
  - id: max_seek_cover_distance
    type: f4
    doc: World Units
  - id: cover_damage_threshold
    type: f4
    doc: Range[0, 1]
  - id: stalking_discovery_time
    type: f4
    doc: Seconds
  - id: stalking_max_distance
    type: f4
    doc: World Units
  - id: stationary_facing_angle
    type: f4
  - id: change_facing_stand_time
    type: f4
    doc: Seconds
  - id: padding16
    size: 4
  - id: uncover_delay_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: target_search_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: pursuit_position_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: num_positions_coord
    type: u2
    doc: Range[0, inf]
  - id: num_positions_normal
    type: u2
    doc: Range[0, inf]
  - id: padding17
    size: 32
  - id: melee_attack_delay
    type: f4
    doc: Seconds
  - id: melee_fudge_factor
    type: f4
    doc: World Units
  - id: melee_charge_time
    type: f4
    doc: Seconds
  - id: melee_leap_range
    #type: bounds("f4")
    type: bounds
    doc: World Units
  - id: melee_leap_velocity
    type: f4
    doc: World Units per tick, Range[0, 1]
  - id: melee_leap_chance
    type: f4
    doc: Range[0, 1]
  - id: melee_leap_ballistic
    type: f4
    doc: Range[0, 1]
  - id: berserk_damage_amount
    type: f4
    doc: Range[0, 1]
  - id: berserk_damage_threshold
    type: f4
    doc: Range[0, 1]
  - id: berserk_proximity
    type: f4
    doc: World Units
  - id: suicide_sensing_dist
    type: f4
    doc: World Units
  - id: berserk_grenade_chance
    type: f4
    doc: Range[0, 1]
  - id: padding18
    size: 12
  - id: guard_position_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: combat_position_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: old_position_avoid_dist
    type: f4
    doc: World Units
  - id: friend_avoid_dist
    type: f4
    doc: |
      World Units

      Constraints the minimum distance that this actor can be from its
      allies. Increase this to avoid actors "clumping" together.
  - id: padding19
    size: 40
  - id: noncombat_idle_speech_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: combat_idle_speech_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: padding20
    size: 48
  - id: padding21
    size: 128
  - id: do_not_use_3
    type: tag_dependency
    doc: actor, unused
  - id: padding22
    size: 48
  - id: do_not_use_1_path
    type: strz
    size: do_not_use_1.path_length + 1
    encoding: ASCII
    if: do_not_use_1.path_length > 0
  - id: do_not_use_2_path
    type: strz
    size: do_not_use_2.path_length + 1
    encoding: ASCII
    if: do_not_use_2.path_length > 0
  - id: do_not_use_3_path
    type: strz
    size: do_not_use_3.path_length + 1
    encoding: ASCII
    if: do_not_use_3.path_length > 0
enums:
  actor_defensive_crouch_type: # size always 2
    0: never
    1: danger
    2: low_shields
    3: hide_behind_shield
    4: any_target
    5: flood_shamble
  actor_type: # size always 2
    0: elite
    1: jackal
    2: grunt
    3: hunter
    4: engineer
    5: assassin
    6: player
    7: marine
    8: crew
    9: combat_form
    10: infection_form
    11: carrier_form
    12: monitor
    13: sentinel
    14: none
    15: mounted_weapon
  actor_unreachable_danger_trigger: # size always 2
    0: never
    1: visible
    2: shooting
    3: shooting_near_us
    4: damaging_us
    5: unused
    6: unused1
    7: unused2
    8: unused3
    9: unused4
types:
  bounds: # TODO we want this from common
    seq:
      - id: min
        type: f4
      - id: max
        type: f4
  vector2dle: # TODO we should parameterize vector2d in common
    seq:
      - id: i
        type: f4le
      - id: j
        type: f4le
