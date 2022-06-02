meta:
  id: tag_dependency
  application: Halo Custom Edition
  license: GPL-3.0-only
  endian: le
doc: |
  Gearbox Halo CE common tag dependency structure.
  Represents a file path reference to another tag file.
seq:
  - id: tag_class
    type: u4 # TODO header.tag_group (aka TagEngineId) enum. Need to be able to import enums.
  - id: path_pointer
    type: u4
    doc: compiled
  - id: path_length
    type: u4
  - id: tag_id # TODO is this a copy of tag_class?
    type: u4
