meta:
  id: antenna
  application: Halo Custom Edition
  file-extension: antenna
  xref:
    tag_group: ant!
  license: GPL-3.0-only
  endian: be
  imports:
    - common/block
    - common/color_argb
    - common/euler2d
    - common/header
    - common/tag_dependency
doc: |
  Gearbox Halo CE antenna tag

  A springy antenna _widget_ which can be attached to [model
  markers][gbxmodel#markers], as seen on the Warthog and Scorpion. Widgets
  can be added to any [object][].
doc-ref: https://c20.reclaimers.net/h1/tags/antenna/
seq:
  - id: header
    type: header
  - id: attachment_marker_name
    type: strz # TagString
    size: 32
    encoding: ASCII
  - id: bitmaps
    type: tag_dependency
    doc: bitmap
  - id: physics
    type: tag_dependency
    doc: point_physics
  - id: padding1
    size: 80
  - id: spring_strength_coefficient
    type: f4
  - id: falloff_pixels
    type: f4
  - id: cutoff_pixels
    type: f4
  - id: length
    type: f4
    doc: cache_only
  - id: padding2
    size: 36
  - id: vertices
    type: block
    doc: antenna_vertex
  - id: bitmaps_path
    type: strz
    size: bitmaps.path_length + 1
    encoding: ASCII
    if: bitmaps.path_length > 0
  - id: physics_path
    type: strz
    size: physics.path_length + 1
    encoding: ASCII
    if: physics.path_length > 0
  - id: vertices_block
    type: antenna_vertex
    repeat: expr
    repeat-expr: vertices.item_count
types:
  antenna_vertex:
    seq:
      - id: spring_strength_coefficient
        type: f4
      - id: padding1
        size: 24
      - id: angles
        type: euler2d
      - id: length
        type: f4
        doc: World Units
      - id: sequence_index
        type: u2
      - id: padding2
        size: 2
      - id: color
        type: color_argb
      - id: lod_color
        type: color_argb
      - id: padding3
        size: 40
      - id: offset
        type: point3dle
        doc: cache_only
  point3dle: # TODO we probably want this parametrized from common
    seq:
      - id: x
        type: f4le
      - id: 'y'
        type: f4le
      - id: z
        type: f4le
