meta:
  id: block
  application: Halo Custom Edition
  license: GPL-3.0-only
  endian: be
doc: |
  Gearbox Halo CE common block

  Header for a variable-sized array of data in a tag.

  The actual block data occurs at the end of the tag data, in the order the
  block fields occur. Any definition that includes block needs a corresponding
  data entry at the end too.
seq:
  - id: item_count
    type: u4
    doc: Gives the number of items in this block.
  - id: pointer
    type: u8 # ptr64
    doc: |
      Compiled

      Pointer to the first item.
