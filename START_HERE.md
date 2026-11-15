# START HERE (instructions for the agent and new contributors)

This repo is a disassembly of NHL 97 for DOS: labelled 32-bit x86 assembly (NASM) that reassembles to the byte-identical
`HOCKEY.EXE`. No C, no compiler. It is modelled on [NHL96PC](https://github.com/abdulahmad/NHL96PC) and
[NHL95PC](https://github.com/abdulahmad/NHL95PC): the same build tools, the same file layout and the same names wherever the games
share code.

## Hard rules

- Never change an EXE byte. Every commit must build to MATCH (SHA-1 `b5cba11fd78b3db4c9085ca11918128e52b76bdd`).
- Never commit game files: no HOCKEY.EXE, no IDA listing, no data, no patches. Supply your own EXE (see below).
- Never force-push, never rewrite pushed history, never push a commit that does not MATCH. Small commits.
- No macros except `LD`. No address where a label works.
- Names: a name from NHL 94 Genesis / SNES or an earlier game wins; then NHL 95 PC / 96 PC names; a 97-only name only when
  no earlier game has the routine. Skip the Watcom runtime and the sound driver internals.

## 1. Setup

NASM 2.15+ and Python 3. Put your NHL 97 `HOCKEY.EXE` (1,865,388 bytes) in `retail/`, or set `NHL97_EXE=/path/to/HOCKEY.EXE`.
The maintainer tools (`tools/build/gen_src.py`, the matchers) also need `pip install iced-x86`.

## 2. Build and confirm MATCH

`./build.sh`: the last line is `MATCH: build/HOCKEY.EXE is byte-identical to the retail HOCKEY.EXE`.
