# Using u1 for booleans. These instances have been marked with comments.
meta:
  id: blam
  application: Halo Custom Edition
  file-extension: sav
  xref:
    filename: blam.sav
  license: GPL-3.0-only
  endian: le
doc: Gearbox Halo CE blam.sav file
doc-ref: https://c20.reclaimers.net/h1/engine/files/#blam-sav
seq:
  - id: padding1
    size: 2
  - id: player_details
    type: player_details
  - id: padding2
    size: 0x14
  - id: controls
    type: control_settings
    doc: |
      Contains input-related settings, including mouse, keyboard, and gamepad
      bindings.
  - id: padding3
    size: 0x10A
  - id: video
    type: video_settings
  - id: padding4
    size: 0x100
  - id: audio
    type: audio_settings
  - id: padding5
    size: 0x20C
  - id: network
    type: network_settings
  - id: padding6
    size: 0x102
  - id: gamepads
    type: pad_info
    repeat: expr
    repeat-expr: 4
  - id: padding7
    size: 0x674
    doc: Unknown region
  - id: crc32_hash
    type: u4
    doc: |
      The blam.sav has a CRC-32 checksum appended at the end of it. The value is
      actually stored in its complement equivalent (i.e. bitwise NOT). The
      checksum validates the data between `0x000` and `0x1FFC` - the checksum
      itself is not included! There is a relatively large amount of padding
      before this field, and it is the final 4 bytes of the file.

      Due to the complement on this field, the entire file will _always_ have a
      CRC of `0xFFFFFFFF`. Therefore the file can be verified by either
      comparing its overall CRC to `0xFFFFFFFF`, or comparing the CRC of its
      prior sections to the complement of this field.
types:
  audio_settings:
    seq:
      - id: volume_master
        type: u1
      - id: volume_effects
        type: u1
      - id: volume_music
        type: u1
      - id: enable_eax
        type: u1 #bool
        doc: EAX is Environmental Audio Extensions
      - id: hardware_accel
        type: u1 # bool
      - id: sound_quality
        type: u1
        enum: quality_options
      - id: padding
        size: 1
      - id: audio_variety
        type: u1
        enum: quality_options
  control_settings:
    seq:
      - id: invert_v_axis
        type: u1 # bool
        doc: |
          Controls if the player's vertical aiming axis controls are inverted,
          e.g. pulling the mouse down aims up.
      - id: padding1
        size: 4
      - id: keyboard_binds
        type: keyboard_binds
        doc: |
          A mapping of 109 keyboard inputs to game functions, each a
          little-endian `uint16` (2 bytes long). The entries are ordered roughly
          like the rows of a QWERTY keyboard, with each position in the array
          corresponding to a certain input key.

          If a key is unbound, then that position holds the bytes `0x7F 0xFF`.
          Otherwise, bound keys store a value representing the game function the
          key is mapped to, for example `0x05 0x00` for flashlight.
      - id: mouse_binds
        type: mouse_binds
        doc: Bindings for the mouse device, similar to the keyboard structure.
      - id: pad_binds
        type: pad_binds
        doc: |
          Bindings for gamepads, similar to the keyboard structure. Supports 4
          controllers, with each controller's input groups interleaved.
      - id: padding2
        size: 26
      - id: mouse_sens_h
        type: u1
        doc: Ranges in value from 0 (minimum) to 10 (maximum).
      - id: mouse_sens_v
        type: u1
        doc: Ranges in value from 0 (minimum) to 10 (maximum).
      - id: pad_sens_h
        type: u1
        repeat: expr
        repeat-expr: 4
        doc: |
          An array of 4 controller horizontal aiming sensitivities. Index using
          `0` for the first controller, `1` for the second, etc.
      - id: pad_sens_v
        type: u1
        repeat: expr
        repeat-expr: 4
        doc: |
          An array of 4 controller vertical aiming sensitivities. Index using
          `0` for the first controller, `1` for the second, etc.
    types:
      keyboard_binds:
        seq:
          - id: escape
            type: u2
            enum: action
            doc: |
              Defaults to `0x09` (MenuBack) and is unchangeable. Hardcoded to
              pause the game.
          - id: f1
            type: u2
            enum: action
            doc: Defaults to `0x0C` (ShowScores)
          - id: f2
            type: u2
            enum: action
            doc: Defaults to `0x1B` (ShowRules)
          - id: f3
            type: u2
            enum: action
            doc: Defaults to `0x1C` (ShowPlayerNames)
          - id: f4
            type: u2
            enum: action
          - id: f5
            type: u2
            enum: action
          - id: f6
            type: u2
            enum: action
          - id: f7
            type: u2
            enum: action
          - id: f8
            type: u2
            enum: action
          - id: f9
            type: u2
            enum: action
          - id: f10
            type: u2
            enum: action
          - id: f11
            type: u2
            enum: action
          - id: f12
            type: u2
            enum: action
          - id: printscreen
            type: u2
            enum: action
            doc: Defaults to `0x12` (Screenshot)
          - id: scroll_lock
            type: u2
            enum: action
          - id: pause_break
            type: u2
            enum: action
          - id: grave
            type: u2
            enum: action
          - id: num_row_1
            type: u2
            enum: action
          - id: num_row_2
            type: u2
            enum: action
          - id: num_row_3
            type: u2
            enum: action
          - id: num_row_4
            type: u2
            enum: action
          - id: num_row_5
            type: u2
            enum: action
          - id: num_row_6
            type: u2
            enum: action
          - id: num_row_7
            type: u2
            enum: action
          - id: num_row_8
            type: u2
            enum: action
          - id: num_row_9
            type: u2
            enum: action
          - id: num_row_0
            type: u2
            enum: action
          - id: en_dash
            type: u2
            enum: action
          - id: equals
            type: u2
            enum: action
          - id: backspace
            type: u2
            enum: action
          - id: tab
            type: u2
            enum: action
            doc: Defaults to `0x03` (SwitchWeapon)
          - id: q
            type: u2
            enum: action
            doc: Defaults to `0x05` (Flashlight)
          - id: w
            type: u2
            enum: action
            doc: Defaults to `0x13` (MoveForward)
          - id: e
            type: u2
            enum: action
            doc: Defaults to `0x02` (Action)
          - id: r
            type: u2
            enum: action
            doc: Defaults to `0x0D` (Reload)
          - id: t
            type: u2
            enum: action
            doc: Defaults to `0x0F` (Say)
          - id: y
            type: u2
            enum: action
            doc: Defaults to `0x10` (SayToTeam)
          - id: u
            type: u2
            enum: action
          - id: i
            type: u2
            enum: action
          - id: o
            type: u2
            enum: action
          - id: p
            type: u2
            enum: action
          - id: bracket_l
            type: u2
            enum: action
          - id: bracket_r
            type: u2
            enum: action
          - id: backslash
            type: u2
            enum: action
          - id: caps_lock
            type: u2
            enum: action
          - id: a
            type: u2
            enum: action
            doc: Defaults to `0x15` (MoveLeft)
          - id: s
            type: u2
            enum: action
            doc: Defaults to `0x14` (MoveBackward)
          - id: d
            type: u2
            enum: action
            doc: Defaults to `0x16` (MoveRight)
          - id: f
            type: u2
            enum: action
            doc: Defaults to `0x04` (MeleeAttack)
          - id: g
            type: u2
            enum: action
            doc: Defaults to `0x01` (SwitchGrenade)
          - id: h
            type: u2
            enum: action
            doc: Defaults to `0x11` (SayToVehicle)
          - id: j
            type: u2
            enum: action
          - id: k
            type: u2
            enum: action
          - id: l
            type: u2
            enum: action
          - id: semicolon
            type: u2
            enum: action
          - id: apostrophe
            type: u2
            enum: action
          - id: enter
            type: u2
            enum: action
            doc: Defaults to `0x08` (MenuAccept). Keyboard only and unchangeable.
          - id: shift_l
            type: u2
            enum: action
          - id: z
            type: u2
            enum: action
            doc: Defaults to `0x0B` (ScopeZoom)
          - id: x
            type: u2
            enum: action
            doc: Defaults to `0x0E` (ExchangeWeapon)
          - id: c
            type: u2
            enum: action
          - id: v
            type: u2
            enum: action
          - id: b
            type: u2
            enum: action
          - id: n
            type: u2
            enum: action
          - id: m
            type: u2
            enum: action
          - id: comma
            type: u2
            enum: action
          - id: period
            type: u2
            enum: action
          - id: slash
            type: u2
            enum: action
          - id: shift_r
            type: u2
            enum: action
          - id: ctrl_l
            type: u2
            enum: action
            doc: Defaults to `0x0A` (Crouch)
          - id: win_l
            type: u2
            enum: action
          - id: alt_l
            type: u2
            enum: action
          - id: space
            type: u2
            enum: action
            doc: Defaults to `0x00` (Jump)
          - id: alt_r
            type: u2
            enum: action
          - id: win_r
            type: u2
            enum: action
            doc: Unchangeable
          - id: menu
            type: u2
            enum: action
            doc: Unchangeable
          - id: ctrl_r
            type: u2
            enum: action
          - id: arrow_up
            type: u2
            enum: action
          - id: arrow_down
            type: u2
            enum: action
          - id: arrow_left
            type: u2
            enum: action
          - id: arrow_right
            type: u2
            enum: action
          - id: insert
            type: u2
            enum: action
          - id: home
            type: u2
            enum: action
          - id: pg_up
            type: u2
            enum: action
          - id: delete
            type: u2
            enum: action
          - id: end
            type: u2
            enum: action
          - id: pg_down
            type: u2
            enum: action
          - id: num_lock
            type: u2
            enum: action
            doc: Unchangeable
          - id: kp_divide
            type: u2
            enum: action
          - id: kp_multiply
            type: u2
            enum: action
          - id: kp_0
            type: u2
            enum: action
          - id: kp_1
            type: u2
            enum: action
          - id: kp_2
            type: u2
            enum: action
          - id: kp_3
            type: u2
            enum: action
          - id: kp_4
            type: u2
            enum: action
          - id: kp_5
            type: u2
            enum: action
          - id: kp_6
            type: u2
            enum: action
          - id: kp_7
            type: u2
            enum: action
          - id: kp_8
            type: u2
            enum: action
          - id: kp_9
            type: u2
            enum: action
          - id: kp_minus
            type: u2
            enum: action
          - id: kp_plus
            type: u2
            enum: action
          - id: unknown_1
            type: u2
            enum: action
            doc: Probably KeyPadEnter
          - id: kp_decimal
            type: u2
            enum: action
          - id: unknown_2
            type: u2
            enum: action
          - id: unknown_3
            type: u2
            enum: action
          - id: unknown_4
            type: u2
            enum: action
          - id: unknown_5
            type: u2
            enum: action
          - id: unknown_6
            type: u2
            enum: action
      mouse_binds:
        seq:
          - id: left
            type: u2
            enum: action
          - id: middle
            type: u2
            enum: action
          - id: right
            type: u2
            enum: action
          - id: btn_4
            type: u2
            enum: action
          - id: btn_5
            type: u2
            enum: action
          - id: btn_6
            type: u2
            enum: action
          - id: btn_7
            type: u2
            enum: action
          - id: btn_8
            type: u2
            enum: action
          - id: h_axis_neg
            type: u2
            enum: action
          - id: h_axis_pos
            type: u2
            enum: action
          - id: v_axis_neg
            type: u2
            enum: action
          - id: v_axis_pos
            type: u2
            enum: action
          - id: wheel_neg
            type: u2
            enum: action
          - id: wheel_pos
            type: u2
            enum: action
      pad_binds:
        seq:
          - id: btns
            type: pad_btn_binds
            repeat: expr
            repeat-expr: 4
          - id: menu
            type: pad_menu_binds
            repeat: expr
            repeat-expr: 4
          - id: axis
            type: pad_axis_binds
            repeat: expr
            repeat-expr: 4
          - id: dpad
            type: pad_dpad_binds
            repeat: expr
            repeat-expr: 4
        types:
          pad_axis_binds:
            seq:
              - id: axis_1_pos
                type: u2
                enum: action
                doc: DirectInput Axis 1+ (Analog - left stick - down)
              - id: axis_1_neg
                type: u2
                enum: action
                doc: DirectInput Axis 1- (Analog - left stick - up)
              - id: axis_2_pos
                type: u2
                enum: action
                doc: DirectInput Axis 2+ (Analog - left stick - right)
              - id: axis_2_neg
                type: u2
                enum: action
                doc: DirectInput Axis 2- (Analog - left stick - left)
              - id: axis_3_pos
                type: u2
                enum: action
                doc: DirectInput Axis 3+ (Analog - right stick - down)
              - id: axis_3_neg
                type: u2
                enum: action
                doc: DirectInput Axis 3- (Analog - right stick - up)
              - id: axis_4_pos
                type: u2
                enum: action
                doc: DirectInput Axis 4+ (Analog - right stick - right)
              - id: axis_4_neg
                type: u2
                enum: action
                doc: DirectInput Axis 4- (Analog - right stick - left)
              - id: axis_5_pos
                type: u2
                enum: action
                doc: DirectInput Axis 5+ (Shoulder - trigger - left)
              - id: axis_5_neg
                type: u2
                enum: action
                doc: DirectInput Axis 5- (Shoulder - trigger - right)
              - id: axis_6_pos
                type: u2
                enum: action
                doc: DirectInput Axis 6+
              - id: axis_6_neg
                type: u2
                enum: action
                doc: DirectInput Axis 6-
              - id: padding
                size: 0x68
          pad_btn_binds:
            seq:
              - id: btn_0
                type: u2
                enum: action
                doc: DirectInput Button 0 (Face - button A)
              - id: btn_1
                type: u2
                enum: action
                doc: DirectInput Button 1 (Face - button B)
              - id: btn_2
                type: u2
                enum: action
                doc: DirectInput Button 2 (Face - button X)
              - id: btn_3
                type: u2
                enum: action
                doc: DirectInput Button 3 (Face - button Y)
              - id: btn_4
                type: u2
                enum: action
                doc: DirectInput Button 4 (Shoulder - left bumper)
              - id: btn_5
                type: u2
                enum: action
                doc: DirectInput Button 5 (Shoulder - right bumper)
              - id: btn_6
                type: u2
                enum: action
                doc: DirectInput Button 6 (Home - back)
              - id: btn_7
                type: u2
                enum: action
                doc: DirectInput Button 7 (Home - start)
              - id: btn_8
                type: u2
                enum: action
                doc: DirectInput Button 8 (Analog - left stick - click)
              - id: btn_9
                type: u2
                enum: action
                doc: DirectInput Button 9 (Analog - right stick - click)
              - id: btn_10
                type: u2
                enum: action
                doc: DirectInput Button 10
              - id: padding
                size: 0x2A
          pad_dpad_binds:
            seq:
              - id: up
                type: u2
                enum: action
                doc: Directional - up
              - id: padding1
                size: 2
              - id: right
                type: u2
                enum: action
                doc: Directional - right
              - id: padding2
                size: 2
              - id: down
                type: u2
                enum: action
                doc: Directional - down
              - id: padding3
                size: 2
              - id: left
                type: u2
                enum: action
                doc: Directional - left
              - id: padding4
                size: 0xF2
          pad_menu_binds:
            seq:
              - id: accept
                type: u2
                enum: dinput_btns
                doc: Holds the button ID used to accept menu selections.
              - id: back
                type: u2
                enum: dinput_btns
                doc: Holds the button ID used to go back in menus.
            enums:
              dinput_btns:
                0x00:
                  id: button_0
                  doc: Face button A
                0x01:
                  id: button_1
                  doc: Face button B
                0x02:
                  id: button_2
                  doc: Face button X
                0x03:
                  id: button_3
                  doc: Face button Y
                0x04:
                  id: button_4
                  doc: Shoulder L, White
                0x05:
                  id: button_5
                  doc: Shoulder R, Black
                0x06:
                  id: button_6
                  doc: Back
                0x07:
                  id: button_7
                  doc: Start
                0x08:
                  id: button_8
                  doc: Left stick click
                0x09:
                  id: button_9
                  doc: Right stick click
                0x0A: button_10
                0x0B: button_11
                0x0C: button_12
                0x0D: button_13
                0x0E: button_14
  network_settings:
    seq:
      - id: server_name
        size: 64
        type: strz
        encoding: utf-16
        doc: |
          Stores the last-used hosting server name for the "create game" menus
          (both LAN and Internet). Null-terminated with a maximum of 31
          characters (excluding the null).
      - id: padding1
        size: 0xE0
      - id: password
        size: 18
        type: strz
        encoding: utf-16
        doc: |
          Stores the last-used hosting password for the "create game" menus
          (both LAN and Internet). Null-terminated with a maximum of 8
          characters (excluding the null).
      - id: padding2
        size: 1
      - id: max_players
        type: u1
        doc: |
          Stores the last-used max players for hosting a server. The value
          `0x00` actually corresponds to the minimum of 2 players, with `0x0E`
          being the maximum of 16.
      - id: pad
        size: 0x100
      - id: connection_type
        type: u1
        enum: connection_types
      - id: server_address
        size: 64
        type: strz
        encoding: utf-16
        doc: |
          Stores the default server address for Direct IP connections. This
          value could contain an IP and port separated by a ":" or even a DNS
          host name. Encoded as UTF-16, null-terminated with a maximum of 31
          characters (excluding the null).
      - id: server_port
        type: u2
        doc: Defaults to 2302
      - id: client_port
        type: u2
        doc: Defaults to 2303
    enums:
      connection_types:
        0:
          id: dial_up
          -orig-id: 56k
        1: dsl_low
        2: dsl_avg
        3: dsl_high
        4: t1_lan
  pad_info:
    seq:
      - id: name
        size: 512
        type: strz
        encoding: utf-16
        doc: |
          Stores the name of the controller device seen when configuring button
          bindings (if configured). UTF-16 String. Some examples are
          "Xbox Controller S via XBCD" or "Xbox 360 Controller For Windows". The
          size of this buffer is unknown, so 512 bytes is assumed. When Halo
          detects two devices with the same name, the second one will have
          " (2)" appended to its name.
      - id: padding1
        size: 12
        doc: |
          This padding size is unknown and depends on the above buffer's size.
      - id: vendor_id
        type: u2
        doc: |
          4-digit hex identifying the vendor/manufacturer of the gamepad.
          For example, `045E` is Microsoft. This would be little-endian encoded
          as `5E 04`. A list of hardware vendor IDs can be
          [found here](https://devicehunt.com/all-usb-vendors).
      - id: product_id
        type: u2
        doc: |
          4-digit hex identifying the gamepad product. For example, `0289`
          (`89 02` little-endian) is the Xbox Controller S. Devices by vendor
          can be [found here (Microsoft)](https://devicehunt.com/view/type/usb/vendor/045E).
      - id: padding2
        size: 6
        doc: Zeroed out values
      - id: pidvid
        size: 6
        type: str
        encoding: ASCII
        doc: An ASCII string with the value "PIDVID"
      - id: dupe_id
        type: u1
        doc: |
          Distinguishes multiple gamepads with the same vendor and product ID.
          Takes the value `0x00`, then `0x01`, etc.
      - id: padding3
        size: 3
  player_details:
    seq:
      - id: name
        size: 24
        type: strz
        encoding: utf-16
        doc: |
          The player's name, encoded as
          [UTF-16](https://en.wikipedia.org/wiki/UTF-16). Null-terminated with a
          maximum of 11 characters (excluding the null).
      - id: padding
        size: 0x100
      - id: color
        type: u1
        enum: player_colors
        doc: |
          Determines the player's multiplayer armor color. Defaults to `0xFF`
          (random).
    enums:
      player_colors:
        0x00: white
        0x01: black
        0x02: red
        0x03: blue
        0x04: gray
        0x05: yellow
        0x06: green
        0x07: pink
        0x0A: purple
        0x0B: cyan
        0x0C: cobalt
        0x0D: orange
        0x0E: teal
        0x0F: sage
        0x10: brown
        0x11: tan
        0x14: maroon
        0x15: salmon
        0xFF: random
  video_settings:
    seq:
      - id: res_width
        type: u2
      - id: res_height
        type: u2
      - id: refresh_rate
        type: u1
        doc: Will take the literal values 59 (`0x3B`) or 60 (`0x3C`)
      - id: unknown
        size: 2
        doc: Has a value of `0x00 0x02`
      - id: frame_rate
        type: u1
        enum: frame_rate_options
      - id: specular
        type: u1 # bool
      - id: shadows
        type: u1 # bool
      - id: decals
        type: u1 # bool
      - id: particles
        type: u1
        enum: particle_settings
      - id: texture_quality
        type: u1
        enum: quality_options
      - id: padding1
        size: 1
      - id: gamma
        type: u1
        doc: "Options: +1 (`0xD8`), +2 (`0xDF`), +3 (`0xE6`)"
      - id: padding2
        size: 1
    enums:
      frame_rate_options:
        0: vsync_off
        1: vsync_on
        2:
          id: fps_30
          -orig-id: 30_fps
      particle_settings:
        0: off
        1: low
        2: high
enums:
  action: # size always 2
    0: jump
    1: switch_grenade
    2: action
    3: switch_weapon
    4: melee_attack
    5: flashlight
    6: throw_grenade
    7: fire_weapon
    8:
      id: menu_accept
      doc: Keyboard only
    9:
      id: menu_back
      doc: Keyboard only
    10: crouch
    11: scope_zoom
    12: show_scores
    13: reload
    14: exchange_weapon
    15: say
    16: say_to_team
    17: say_to_vehicle
    18: screenshot
    19: move_forward
    20: move_backward
    21: move_left
    22: move_right
    23: look_up
    24: look_down
    25: look_left
    26: look_right
    27: show_rules
    28: show_player_names
  quality_options: # size always 2
    0: low
    1: medium
    2: high