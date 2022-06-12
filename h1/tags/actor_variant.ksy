meta:
  id: actor_variant
  application: Halo Custom Edition
  file-extension: actor_variant
  xref:
    tag_group: actv
  license: GPL-3.0-only
  endian: be
  imports:
    - common/block
    - common/color_rgb
    - common/header
    - common/tag_dependency
    - common/vector3d
doc: |
  Gearbox Halo CE actor variant tag

  Specializes an [actor][] by defining their use of weapons, grenades,
  their health, their color, and what equipment they drop.
doc-ref: https://c20.reclaimers.net/h1/tags/actor_variant/
seq:
  - id: header
    type: header
  - id: flags # TODO bitfield ActorVariantFlags
    type: u4
  - id: actor_definition
    type: tag_dependency
    doc: actor
  - id: unit
    type: tag_dependency
    doc: |
      unit

      Specifies which [biped][] this variant will spawn as.
  - id: major_variant
    type: tag_dependency
    doc: |
      actor_variant

      Specifies the next highest "rank" of this actor variant. This allows
      enemies to "upgrade" in higher difficulties, with the chance being
      controlled by both the per-difficulty _major upgrade_ [globals][]
      multipliers and the _major upgrade_ squad setting in the
      [scenario][].
  - id: metagame_type
    type: u2
    enum: mcc_metagame_type
    doc: |
      h1a_only

      Used for kill scoring and achievements in MCC. Since this field was
      padding in pre-MCC editions, maps compiled for MCC should use
      MCC-native _actor\_variant_ tags or set these fields, or else
      enemies may be scored as Brutes or other unexpected types due to
      having zeroed-out or garbage data.
  - id: metagame_class
    type: u2
    enum: mcc_metagame_class
    doc: |
      h1a_only

      Used for kill scoring and achievements in MCC.
  - id: padding01
    size: 20
  - id: movement_type
    type: u2
    enum: movement_type
  - id: padding02
    size: 2
  - id: initial_crouch_chance
    type: f4
    doc: Range[0, 1]
  - id: crouch_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: run_time
    #type: bounds("f4")
    type: bounds
    doc: Seconds
  - id: weapon
    type: tag_dependency
    doc: |
      weapon

      The _weapon_ that the actor spawns with.
  - id: maximum_firing_distance
    type: f4
    doc: |
      World Units

      The maximum range, in world units, where the unit can fire at a target.
  - id: rate_of_fire
    type: f4
    doc: |
      This lets you pick the firing rate for this actor. Which affects
      firing behavior in the following ways:

      - Any above `0` rate of fire is limited by the referenced _weapon's_
        minimum _rounds per second_ as the actor will only tap the trigger
        not hold, not causing the firing speed to climb.

      - When set to `0`, the actor will hold the trigger causing it to use
      the
        weapon's windup behavior and allows it to reach the weapon's max firing rate.

      - If `0` and the weapon is a charging weapon the actor will hold the
      charge until
        the burst ends or the weapon's [overcharged action behavior](weapon#tag-field-triggers-charging-time) kicks in.

      - If not `0` charging the weapon will fire their uncharged
      projectiles if they have them.

      - Setting a number higher than the weapon's minimum rate of fire can
      prompt
        the actor to fire their gun slower than the weapon's minimum because it will
        try to tap fire at every `1/rate_of_fire` causing it to not be able to fire
        again immediately after the firing delay.
  - id: projectile_error
    type: f4
    doc: |
      Adds error on top of the weapon's own error. This makes actors fire
      inaccurately.
  - id: first_burst_delay_time
    #type: bounds("f4")
    type: bounds
    doc: |
      Seconds

      The delay in seconds before the actor starts its first burst on a
      new target.
  - id: new_target_firing_pattern_time
    type: f4
    doc: Seconds
  - id: surprise_delay_time
    type: f4
    doc: Seconds
  - id: surprise_fire_wildly_time
    type: f4
    doc: Seconds
  - id: death_fire_wildly_chance
    type: f4
    doc: |
      Range[0, 1]

      Sets the chance that the actor will fire their weapon while dying.
  - id: death_fire_wildly_time
    type: f4
    doc: |
      Seconds

      Controls how long the actor will continue firing after death.
  - id: desired_combat_range
    #type: bounds("f4")
    type: bounds
    doc: |
      World Units

      The distance in world units the actor will try to be in to attack;
      lower bounds is the minimum range and upper is the maximum. The
      actor may still fire outside this range, but will [move to attain
      it][ai#firing-positions].
  - id: custom_stand_gun_offset
    type: vector3d
  - id: custom_crouch_gun_offset
    type: vector3d
  - id: target_tracking
    type: f4
    doc: |
      Range[0, 1]

      Determines how closely the actor will follow moving targets when
      firing. bursts. A value of `0` means only firing at the target's
      location at the start of the burst, while while `1` means following
      the target perfectly. with each shot. A value in-between can be
      provided.
  - id: target_leading
    type: f4
    doc: |
      Range[0, 1]

      Determines how accurately to predict lead on moving targets. A value
      of `0` means not leading at all and shooting directly at the target,
      while `1` means perfectly predicting how far in front of the target
      to lead based on [projectile][] speed and distance. A value
      in-between can be provided.
  - id: weapon_damage_modifier
    type: f4
    doc: |
      Allows weapon damage to be buffed or nerfed for this actor variant.
      A value of 0 disables this modifier.
  - id: damage_per_second
    type: f4
    doc: Overrides weapon damage if set and _weapon damage modifier_ is 0.
  - id: burst_origin_radius
    type: f4
    doc: |
      World Units

      The starting point of the burst, randomly to the left or right of
      the target in world units.
  - id: burst_origin_angle
    type: f4
    doc: |
      Controls the maximum angle from horizontal that the orgin can be,
      from the point of view of the actor. For example, a value of `0`
      indicates the origin will alway be directly to the left or right of
      the target, while `90` would allow the origin to be above or below
      the target as well.
  - id: burst_return_length
    #type: bounds("f4")
    type: bounds
    doc: |
      World Units

      How far the burst point moves back towards the target. This can be
      negative to make the burst lead _away_ from the target.
  - id: burst_return_angle
    type: f4
    doc: Controls how close to horizontal the return motion can be.
  - id: burst_duration
    #type: bounds("f4")
    type: bounds
    doc:
      Seconds

      Cotrols the length of burst, during which multiple shots are fired.
  - id: burst_separation
    #type: bounds("f4")
    type: bounds
    doc: |
      Seconds

      Controls how long to wait between bursts.
  - id: burst_angular_velocity
    type: f4
    doc: |
      Degrees per second

      Sets the maximum rotational rate that the burst can sweep. A value
      of `0` means unlimited. For example, if the _burst origin radius_ is
      large and the _burst duration_ is short, the return burst will cover
      a large area in a short amount of time unless limited by this
      angular velocity.
  - id: padding03
    size: 4
  - id: special_damage_modifier
    type: f4
    doc: |
      Range[0, 1]

      A damage modifier for special weapon fire (e.g. overcharged shots
      and secondary triggers), applied in addition to the normal damage
      modifier. No effect if `0`.
  - id: special_projectile_error
    type: f4
    doc: An error angle, applied in addition to normal error, for special fire.
  - id: new_target_burst_duration
    type: f4
    doc: |
      Multiplier for _burst duration_ in the new target state. No effect
      if `0`.
  - id: new_target_burst_separation
    type: f4
    doc: |
      Multiplier for _burst separation_ in the new target state. No effect
      if `0`.
  - id: new_target_rate_of_fire
    type: f4
    doc: |
      Multiplier for _rate of fire_ in the new target state. No effect if `0`.
  - id: new_target_projectile_error
    type: f4
    doc: |
      Multiplier for _projectile error_ in the new target state. No effect
      if `0`.
  - id: padding04
    size: 8
  - id: moving_burst_duration
    type: f4
    doc: Multiplier for _burst duration_ in the moving state. No effect if `0`.
  - id: moving_burst_separation
    type: f4
    doc: |
      Multiplier for _burst separation_ in the moving state. No effect if `0`.
  - id: moving_rate_of_fire
    type: f4
    doc: Multiplier for _rate of fire_ in the moving state. No effect if `0`.
  - id: moving_projectile_error
    type: f4
    doc: |
      Multiplier for _projectile error_ in the moving state. No effect if `0`.
  - id: padding05
    size: 8
  - id: berserk_burst_duration
    type: f4
    doc: |
      Multiplier for _burst duration_ in the berserk state. No effect if `0`.
  - id: berserk_burst_separation
    type: f4
    doc: |
      Multiplier for _burst separation_ in the berserk state. No effect if `0`.
  - id: berserk_rate_of_fire
    type: f4
    doc: Multiplier for _rate of fire_ in the berserk state. No effect if `0`.
  - id: berserk_projectile_error
    type: f4
    doc: |
      Multiplier for _projectile error_ in the berserk state. No effect if `0`.
  - id: padding06
    size: 8
  - id: super_ballistic_range
    type: f4
  - id: bombardment_range
    type: f4
    doc: |
      When non-zero, causes the burst target to be offset by a random
      distance in this range when the enemy is _not visible_.
  - id: modified_vision_range
    type: f4
    doc: |
      Overrides the [actor's vision
      range][actor#tag-field-max-vision-distance]. Normal if `0`.
  - id: special_fire_mode
    type: u2
    enum: special_fire_mode
    doc: If set, allows the actor to use their weapon in alternate ways.
  - id: special_fire_situation
    type: u2
    enum: special_fire_situation
    doc: |
      Determines the situation in which the actor has a chance of using
      special fire.
  - id: special_fire_chance
    type: f4
    doc: |
      Range[0, 1]

      How likely the actor will use their weapon's special fire mode.
      Setting this to `0` is equivalent to using the _never_ situation.
  - id: special_fire_delay
    type: f4
    doc: |
      Seconds

      How long the actor must wait between uses of special fire mode.
  - id: melee_range
    type: f4
    doc: |
      World Units

      Sets how close an enemy must get to trigger a melee charge by the actor.
  - id: melee_abort_range
    type: f4
    doc: |
      World Units

      The actor will stop trying to melee the enemy goes outside this range.
  - id: berserk_firing_ranges
    #type: bounds("f4")
    type: bounds
    doc: |
      World Units

      When berserking and outside the maximum range, the actor will
      advance towards the target and stop at the minimum range.
  - id: berserk_melee_range
    type: f4
    doc: |
      World Units

      Similar to _melee range_, but used when the actor is berserking.
  - id: berserk_melee_abort_range
    type: f4
    doc: |
      World Units

      Similar to _melee abort range_, but used when the actor is berserking.
  - id: padding07
    size: 8
  - id: grenade_type
    type: u2
    enum: grenade_type
    doc: |
      Sets which type of grenade the actor throws, assuming _grenade
      stimulus_ is not _never_.
  - id: trajectory_type
    type: u2
    enum: grenade_trajectory_type
  - id: grenade_stimulus
    type: u2
    enum: grenade_stimulus
    doc: |
      What causes the actor to consider throwing a grenade. It is still
      dependent upon _grenade chance_.
  - id: minimum_enemy_count
    type: u2
    doc: |
      How many enemies must be within the grenade's radius before the
      actor considers throwing there.
  - id: enemy_radius
    type: f4
    doc: |
      World Units

      Only enemies within this radius of the actor are considered when
      choosing where to throw a grenade.
  - id: padding08
    size: 4
  - id: grenade_velocity
    type: f4
    doc: |
      World Units per Second

      This is responsibile for giving the grenade it's thrown velocity,
      rather than the [projectile _initial
      velocity_][projectile#tag-field-initial-velocity] or the [unit
      _grenade velocity_][unit#tag-field-grenade-velocity].
  - id: grenade_ranges
    #type: bounds("f4")
    type: bounds
    doc: |
      World Units

      The minimum and maximum ranges that the actor will consider throwing
      a grenade.
  - id: collateral_damage_radius
    type: f4
    doc: |
      World Units

      If there are friendlies within this radius of the target, grenades
      will not be thrown.
  - id: grenade_chance
    type: f4
    doc: |
      Range[0, 1]

      How likely the actor is to throw a grenade when a _grenade stimulus_
      applies.
  - id: grenade_check_time
    type: f4
    doc: |
      Seconds

      How often to consider throwing a grenade while a continuous _grenade
      stimulus_, like _visible target_, applies.
  - id: encounter_grenade_timeout
    type: f4
    doc: |
      Seconds

      The AI will not throw a grenade if another AI in the
      [encounter][scenario#encounters] threw one within this timeout. This
      prevents AI from all throwing grenades at the same time.
  - id: padding09
    size: 20
  - id: equipment
    type: tag_dependency
    doc: |
      equipment

      References equipment that the actor will drop on death. Note that
      their weapon will already be dropped and does not need to be
      repeated here.
  - id: grenade_count
    #type: bounds("u2")
    type: bounds_u2
    doc: |
      Determines how many grenades the actor spawns with, with the type
      determined by the _grenade type_ field. The actor will use up these
      grenades unless _has unlimited grenades_ is true. On death, the
      grenades are dropped.
  - id: dont_drop_grenades_chance
    type: f4
    doc: |
      Range[0, 1]

      The chance that the actor drops no grenades on death, even if they
      have some.
  - id: drop_weapon_loaded
    #type: bounds("f4")
    type: bounds
    doc: |
      Fractions of a clip

      Range[0, 1]

      A random range for how loaded the dropped weapon is, as a fraction
      of its magazine size or charge. Plasma weapons are dropped at 100%
      charge no matter this field's value under special circumstances: *
      If a model region was destroyed and that region's [_forces drop
      weapon_
      flag][model_collision_geometry#tag-field-regions-forces-drop-weapon]
      is enabled, such as shooting the arm off a Flood actor. * If the
      actor has a chance of [feigning death][unit#feigning-death] and
      reviving, but not if the damage exceeds the _hard death threshold_.
  - id: drop_weapon_ammo
    #type: bounds("u2")
    type: bounds_u2
    doc: |
      Rounds

      The total number of reserve ammo rounds included with the dropped
      weapon. Ignored for energy weapons.
  - id: padding10
    size: 12
  - id: padding11
    size: 16
  - id: body_vitality
    type: f4
    doc: |
      Overrides the biped's [collision geometry _maximum body
      vitality_][model_collision_geometry#tag-field-maximum-body-vitality]
      for a different amount of health.
  - id: shield_vitality
    type: f4
    doc: |
      Overrides the biped's [collision geometry _maximum shield
      vitality_][model_collision_geometry#tag-field-maximum-body-vitality]
      for a different amount of shields.
  - id: shield_sapping_radius
    type: f4
    doc: World Units
  - id: forced_shader_permutation
    type: u2
    doc: |
      If non-zero, forces the bitmap index for any shader the biped uses.
      For example, the Elite major uses the value `1` which forces its
      shaders to use the second (red) cubemap in
      `characters\elite\bitmaps\cubemaps.bitmap`. [Bitmap tags][bitmap]
      which do not have a bitmap for this index will instead use the first
      map (index `0`).
  - id: padding12
    size: 2
  - id: padding13
    size: 16
  - id: padding14
    size: 12
  - id: change_colors
    type: block
    doc: |
      change_colors
      max count 4

      Overrides biped's color change permutations.
  - id: actor_definition_path
    type: strz
    size: actor_definition.path_length + 1
    encoding: ASCII
    if: actor_definition.path_length > 0
  - id: unit_path
    type: strz
    size: unit.path_length + 1
    encoding: ASCII
    if: unit.path_length > 0
  - id: major_variant_path
    type: strz
    size: major_variant.path_length + 1
    encoding: ASCII
    if: major_variant.path_length > 0
  - id: weapon_path
    type: strz
    size: weapon.path_length + 1
    encoding: ASCII
    if: weapon.path_length > 0
  - id: equipment_path
    type: strz
    size: equipment.path_length + 1
    encoding: ASCII
    if: equipment.path_length > 0
  - id: change_colors_block
    type: change_colors
    repeat: expr
    repeat-expr: change_colors.item_count
enums:
  grenade_stimulus: # Size always 2
    0:
      id: never
      doc: The actor never throws grenades.
    1: visible_target
    2: seek_cover
  grenade_trajectory_type: # Size always 2
    0: toss
    1: lob
    2: bounce
  grenade_type: # TODO want this from common, Size always 2
    0: human_fragmentation
    1: covenant_plasma
  movement_type: # Size always 2
    0: always_run
    1: always_crouch
    2: switch_types
  mcc_metagame_class: # Size always 2
    0: infantry
    1: leader
    2: hero
    3: specialist
    4: light_vehicle
    5: heavy_vehicle
    6: giant_vehicle
    7: standard_vehicle
  mcc_metagame_type: # Size always 2
    0: brute
    1: grunt
    2: jackal
    3: skirmisher
    4: marine
    5: spartan
    6:
      id: bugger
      doc: Also called "drone".
    7: hunter
    8: flood_infection
    9: flood_carrier
    10: flood_combat
    11: flood_pure
    12: sentinel
    13: elite
    14:
      id: engineer
      doc: Also called "huragok".
    15: mule
    16: turret
    17: mongoose
    18: warthog
    19: scorpion
    20: hornet
    21: pelican
    22: revenant
    23: seraph
    24: shade
    25: watchtower
    26: ghost
    27: chopper
    28:
      id: mauler
      doc: Also called "prowler".
    29: wraith
    30: banshee
    31: phantom
    32: scarab
    33: guntower
    34:
      id: tuning_fork
      doc: Also called "spirit".
    35: broadsword
    36: mammoth
    37: lich
    38: mantis
    39: wasp
    40: phaeton
    41:
      id: bishop
      doc: Also called "watcher".
    42: knight
    43:
      id: pawn
      doc: Also called "crawler".
  special_fire_mode: # Size always 2
    0:
      id: none
      doc: No special fire will be used.
    1:
      id: overcharge
      doc: |
        The actor will hold down the primary trigger for an overcharged
        shot. Jackals use this with the plasma pistol.
    2:
      id: secondary_trigger
      doc: |
        The actor will fire the weapon's secondary
        [trigger][weapon#tag-field-triggers].
  special_fire_situation: # Size always 2
    0:
      id: never
      doc: The actor will never special fire their weapon.
    1:
      id: enemy_visible
      doc: Special fire happens only when the target is visible.
    2:
      id: enemy_out_of_sight
      doc: Special fire happens only when the target is behind cover.
    3: strafing
types:
  bounds: # TODO we want this from common
    seq:
      - id: min
        type: f4
      - id: max
        type: f4
  bounds_u2: # TODO want this from common
    seq:
      - id: min
        type: u2
      - id: max
        type: u2
  change_colors:
    seq:
      - id: lower_bound
        type: color_rgb
      - id: upper_bound
        type: color_rgb
      - id: padding
        size: 8
