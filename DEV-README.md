# Intro
Kaitai Struct's documentation and guidance is generally pretty good.
This document highlights the most important things for this project, as well as
some quirks we need to be aware of.

# Our fork of Kaitai Struct Compiler (ksc)
Pull requests seem to get merged slowly in the official compiler. We open PRs
for all of our additions / fixes to the Construct target, but we want to use
them without waiting for PRs to get accepted, so we develop using our own fork.
https://github.com/Sigmmma/kaitai_struct_compiler

All of our changes are locally merged into the `sigmmma-master` branch, but any
additional work should be done off of `master` so we can cleanly submit the
changes to Kaitai.

**Any changes must be submitted to the official Kaitai repo**. This is both
for GPL compliance and to, you know, not be an asshole.

For fun, here's a list of our contributions to Kaitai:
- https://github.com/kaitai-io/kaitai_struct_compiler/pull/240
- https://github.com/kaitai-io/kaitai_struct_compiler/pull/241
- https://github.com/kaitai-io/kaitai_struct_compiler/pull/242
- https://github.com/kaitai-io/kaitai_struct_compiler/pull/243
- https://github.com/kaitai-io/kaitai_struct_compiler/pull/246

# Testing
We have a basic test suite to check for common KSY issues.
You'll need the Kaitai Struct compiler (ksc) and a Python environment set up to
run tests. We have a nice script to automate setup. Make sure you run it from
`test/`.
```
cd test
./setup.sh
```
The `./full_test.sh` script will compile definitions with `ksy` and run tests.
If you just want to run the tests without recompiling, simply run `pytest`.

# KSY things

## Order of attributes
Follow KS guidance https://doc.kaitai.io/ksy_style_guide.html#seq-attr

## meta xref
The `xref` meta field can have whatever we want in it, so we use it to embed
some helpful information Kaitai itself doesn't use.
- `tag_group` - The internal, 4 character tag ID (if any)
- `filename` - For files where the full name is constant (e.g. `blam.sav`)

## doc-ref
Each top-level file should link to its corresponding C20 page using `doc-ref`
at the top level of the YAML.
```yaml
doc-ref: https://c20.reclaimers.net/h1/engine/files/#savegame-bin
```

## Endianness
Consider Halo stuff to have big endian by default. Set this in `meta`.
If individual fields use little endian, set that for the individual field.
The exception is files like `blam.ksy`, where the whole file is little endian.
```yaml
meta:
  endian: be
```

## Padding
Pad fields do not have a type, but must have a unique ID. Use the name
`padding`, appending a number if there is more than one (e.g. `padding3`).
Also see [Numbering](#Numbering).
```yaml
- id: padding
  size: 12
```

## type: boolean
The Kaitai guide says to use `b1` for booleans. The `ksy` format interprets `b1`
as a single bit, but in Halo's case, booleans are bytes, so we use `u1` for this
instead. We mark cases where we do this with a comment.
https://github.com/kaitai-io/kaitai_struct/issues/377#issuecomment-374001844
```yaml
- id: shadows
  type: u1 # bool
```
(The `ksc` Construct target does not support `b1` anyway. It outputs `???`).

## Common types
Types like `Bounds` and `Euler3D` used in multiple files should each be their
own `ksy` file in a `common` subdirectory.

Due to an open issue in Kaitai Struct's compiler, only one common imported type
can be in each file, and must be the top-level `seq` element. This means we
**cannot** use a common file for enums, currently.
- https://github.com/kaitai-io/kaitai_struct/issues/876
- https://github.com/kaitai-io/kaitai_struct/issues/703

## Bitfields
We simply use unsigned integers and leave it up to the consuming application to
unpack the values. The name of a bitfield field should contain "flags",
preferably at the end of the name, with a comment explaining what bitfield it is
referencing. This name comes from Invader/C20's definitions.

Kaitai does have the "instance" field for unpacking bitfields, but because it
does not currently support writing, we can't safely use that functionality right
now.
```yaml
- id: my_cool_flags
  type: u2 # bitfield SomeNamedBitfield
```

## Numbering
Many applications sort fields alpha-numerically, so numbered fields (e.g.
`padding123`) should have leading zeros when appropriate.
For example, if there are 15 padding fields, they should be named `padding01`,
`padding02`, ..., `padding15`.

## Blocks
Halo tags handle variable-length block data with a constant-size, inline field
that describes the block (length, type, etc...). They then append the actual
block data at the end of the tag, in the order the description fields appear.

We expect a sister field at the end of the tag for the following types:
- `block`
- `tag_dependency`
