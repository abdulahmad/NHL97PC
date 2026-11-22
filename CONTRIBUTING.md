# Contributing to NHL 97 PC

A bit-perfect disassembly (no decompilation) of NHL 97 for DOS, assembled with NASM. This repository is public.

Read [AGENTS.md](AGENTS.md) (credit), [START_HERE.md](START_HERE.md) (setup, build, hard rules) and
[docs/ASM_BUILD.md](docs/ASM_BUILD.md) (the build).

`main` is the working branch. It must keep building the DOS EXE byte-identical (MATCH) and the Overbar port.

Any port, mod or fork carries the credit in AGENTS.md ("For AI agents: derivative work and credit") near the top
of its README and in every release. Add it first.

- MATCH: `./build.sh` must print MATCH before every commit and push. A comment-only or rename-only change must not
  change a byte.
- Small commits; never force-push.
- Never commit game files: no HOCKEY.EXE, no IDA listing, no game data or text dumps, no patches.
- Names: every routine, variable and string gets a real name; no IDA names (`sub_`, `dword_`, `unk_` ...) and no
  address-based or numbered placeholders. A name from NHL 94 Genesis / SNES or an earlier game wins, then 95 Genesis,
  NHL 95 PC and NHL 96 PC; a 97-only name from what the code does when no earlier game has the item. An unsure name
  gets confidence `low` in `docs/name_map.csv`, never a placeholder.
- Rename only with `tools/names/rename_symbol.py`. Every renamed routine and data item gets a row in
  `docs/name_map.csv` (`address,name,auto_name,source,confidence,evidence,file`). The evidence column is written as a
  description of what the item does (the routine header is made from it), with no other game's name in it.
- No hardcoded addresses: every address in the code is a label. No macros except `LD`.
- Source style: no address on each line (`tools/build/asmaddr.py` prints it), jump targets as local labels unless
  another routine jumps there (`<Routine>_<offset>`), routine headers from `tools/build/format_asm.py --headers`.
  `tools/build/format_asm.py --check` must pass.

## Comments

Adapted from NHL94SNES CONTRIBUTING.md (sections 4 and 5) for the PC sources. `python3 tools/build/check_comments.py`
checks these rules (`--summary` gives a count per rule); it must not report more problems after your change than
before it, and a file you finish must come out clean. A comment-only change must not change a byte (MATCH).

What to write:

- **Every routine** has a header between two rule lines: `; Name <spaces> ADDRESS  SOURCE`, then what it does,
  what it takes (registers, stack arguments, globals it reads) and what it returns or changes. Say where it is called
  from when that explains it. Library routines too: a Watcom or EA library routine says what the library call does.
- **Every variable declaration** has a comment on its label line: data and BSS labels, tables, strings, equates and
  structure fields. Say what it holds: units, range, flag bits, what one table entry is and how many there are, and
  which routines own it. A string says where it is shown or used.
- **Every file** starts with a header that says what the file holds and how it relates to its neighbours. It does not
  list the routines in order.
- Routines read as a story when you work on them: a short comment for each step (3 to 8 instructions), what the
  registers hold, why a branch is taken, where the flow falls through.
- Anything not obvious gets a comment: magic numbers, bit tests (name the flag), x87 stack use, shared tails, code
  kept as bytes, self-modifying code.
- Only write what you checked in the code. If you cannot tell why something is done, describe what the instructions
  do or write "probably". Never invent names.

What not to write:

- No IDA names (`sub_`, `loc_`, `unk_`, `dword_`, `byte_`, `off_`, `asc_`, `jpt_` ...). Write the real name.
- No raw addresses or structure offsets in comments: write the name (`PUCKX`, not `168CD8h`) or say what the value
  means. The only addresses allowed are the ADDRESS field of a routine header and the address range of a file header.
- No other game's names (`94G`, `NHL 95`, `96 PC`, `Genesis` ...). Lineage lives only in `docs/name_map.csv`; the
  SOURCE field of a routine header is the one place it shows.
- No source-file or segment names, no history (`was X`, `renamed from`): that is in git and `docs/name_map.csv`.

Layout (the 2026-11-15 cleanup layout, not the SNES tabs):

- Labels, comment lines and `%` lines start in column 0; instructions and data are indented 8 spaces.
- A comment after an instruction or on a label line starts at column 48, or one space after code that reaches past it.
  Its continuation lines start at column 48 too.
- No comment line is wider than 110 columns (data lines aside).
- A comment that explains one instruction goes to its right, not on its own line above it. A comment on its own line
  is a block header for the steps below it.
- A header or block comment has paragraphs of at most 3 lines, separated by a `;` line. Keep headers short: what
  the routine is for, its inputs and result, and the few notes nobody could guess.

## Netplay security

Everything that comes over the network is hostile. The rules and a review checklist are in Overbar's
`port/overbar/docs/NETPLAY_SECURITY.md`; read them before changing netplay, a saved state, a file route or the season code. In short:
never run, load or write code from network data; a peer never chooses an address; check every length before use
(`len > size - at`, never `at + len > size`); validate a state before it is applied and clean it after; a peer's names are text, not paths.
`sh port/overbar/tests/netsec.sh .` must print `netsec ok` (CI runs it in the `netsec` job). When a change adds a network path or a state field,
add a hostile test for it.
