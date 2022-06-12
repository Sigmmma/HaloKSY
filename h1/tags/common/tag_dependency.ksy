meta:
  id: tag_dependency
  application: Halo Custom Edition
  license: GPL-3.0-only
  endian: be
doc: |
  Gearbox Halo CE common tag dependency structure.
  Represents a file path reference to another tag file.

  The actual path string data occurs at the end of the tag data, in the order
  the tag_dependency fields occur. Any defintion that includes a tag_dependency
  needs a corresponding null-terminated ASCII string entry at the end too.

  HOWEVER, if `path_length` is 0, that path string is not included at the end of
  the data. Not even the null-terminator. Because of this, we need to use
  a conditional for this field inclusion, like this:
  ```
  type: strz
  size: field.path_length + 1
  encoding: ASCII
  if: field.path_length > 0
  ```
seq:
  - id: tag_class
    type: u4 # TODO header.tag_group (aka TagEngineId) enum. Need to be able to import enums.
  - id: path_pointer
    type: u4
    doc: compiled
  - id: path_length
    type: u4
  - id: tag_id
    type: u4
    doc: Only valid in compiled map. Refers to the index the tag exists at.
