meta:
  id: wind
  application: Halo Custom Edition
  file-extension: wind
  xref:
    tag_group: wind
  license: GPL-3.0-only
  endian: be
  imports:
    #- common/bounds
    - common/euler2d
    - common/header
doc: |
  Gearbox Halo CE wind tag

  Describes the speed and variation of wind in a
  [BSP cluster][scenario_structure_bsp#clusters-and-cluster-data], affecting
  local [point_physics][] like [flags][flag] and
  [weather][weather_particle_system].
doc-ref: https://c20.reclaimers.net/h1/tags/wind/
seq:
  - id: header
    type: header
  - id: velocity
    #type: bounds("f4")
    type: bounds
    doc: |
      World Units.

      Upper and lower bounds for wind speed. Technically, this is not a true
      "velocity" because it is not a vector; wind direction is set in the BSP's
      weather palettes.
  - id: variation_area
    type: euler2d
  - id: local_variation_weight
    type: f4
  - id: local_variation_rate
    type: f4
  - id: damping
    type: f4
  - id: padding
    size: 36
types:
  bounds: # TODO we want this from common
    seq:
      - id: min
        type: f4
      - id: max
        type: f4
