meta:
  id: savegame
  application: Halo Custom Edition
  file-extension: bin
  xref:
    filename: savegame.bin
  license: GPL-3.0-only
  endian: be
doc: Gearbox Halo CE savegame.bin file
doc-ref: https://c20.reclaimers.net/h1/engine/files/#savegame-bin
seq:
  - id: unknown1
    size: 0x1E2
  - id: last_difficulty
    type: u1
    enum: difficulty_opts
  - id: unknown2
    size: 5
  - id: last_played_scenario
    type: strz
    size: 32
    encoding: ASCII
    doc: |
      An ASCII-encoded [scenario][] tag path, null-terminated and 32 characters
      max. An example value is `levels\b30\b30` for The Silent Cartographer.
  - id: state
    size-eos: true
    doc: |
      Everything after the header is essentially a memcpy of Halo's game state.
enums:
  difficulty_opts:
    0: easy
    1: normal
    2: hard
    3: legendary
