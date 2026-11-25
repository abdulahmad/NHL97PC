# Assembly build

`./build.sh` (NASM 2.15.05 and Python 3; NASM 2.16 encodes some instructions differently and the EXE does not match. Set `NASM=` to
the 2.15.05 binary if your system nasm is newer):

1. `tools/build/rebuild_exe.py extract your HOCKEY.EXE build/parts`: checks the SHA-1 and takes the third-party
   parts from your EXE: the Watcom wstub (NHL 97 has no bound DOS/4GW: DOS4GW.EXE ships beside the game), the LE header fields and the order
   of the fixup records.
2. `nasm -O0 -f elf32 -I src/inc/` for every file of `src/segments.txt`.
3. `tools/build/link_src.py`: each file holds one section `s_<ADDR>`, placed at that linear address. Globals are
   resolved by name. `R_386_32` becomes a 32-bit LE fixup (the stored value is object-relative, as wlink writes it);
   `R_386_PC32` and `R_386_PC8` are resolved in place. The fixup set comes from the relocations only; the EXE's own
   table gives the record order. The EXE is written and compared: the last line is `MATCH` or `MISMATCH`, with the
   first differing addresses.

Layout rules:

- `src/segments.txt` is the link list: object, start, end, initialised bytes, module, file. A file must assemble to
  exactly its size (`assembled size ..., segment size ...` is a link error). Replace an instruction only with one
  of the same length.
- Every instruction line ends with `; <address>`, its address in the EXE.
- `src/inc/hockey.inc` is included by every file: equates and the `LD` macro only, no bytes.
- `LD op, dst, src` (`src/inc/x86enc.inc`): the load form of a reg,reg instruction, which NASM never emits by
  itself. It is the only macro.
- `jmp 0:label wrt ..gotoff`: a far jump whose offset carries a 16:32 pointer fixup. `wrt ..gotoff` makes NASM
  write a relocation the linker recognises (`R_386_GOTOFF`) and turns into LE source type 6; the field stays zero
  in the file, as wlink leaves it.
- A raw `db` line with an instruction in its comment is an encoding NASM would choose differently. Keep the bytes.
- `src/inc/symbols.inc` is the generated index of cross-file labels (`tools/build/update_symbols.py`); never edit it.
- `port/game_syms.h` (port branch only) is generated the same way by `tools/build/gen_port_syms.py`: the port writes a game address as `SYM_<label>`; run the tool after a rename, a missing label is an error.

Tools:

| tool | use |
|---|---|
| `tools/names/rename_symbol.py OLD NEW --evidence ... --source ...` | rename everywhere, rebuild (must MATCH), record in docs/name_map.csv |
| `tools/names/auto_names.py <module>` / `--summary` | what is still to name in a file |
| `tools/names/func_features.py`, `match95.py`, `import_match95.py` | match against NHL95PC (docstrings give the commands) |
| `tools/build/module_atoms.py`, `build_segmap.py` | module evidence and the segment map (maintainers) |
| `tools/build/gen_src.py` | regenerates `src/` from the EXE: it throws away hand edits and refuses without `--force` |

## Patch 1.1

`./build.sh 11 [path/to/HOCKEY.EXE]` builds patch 1.1 from the same source: `build/v11/HOCKEY.EXE`, 1,871,324
bytes, SHA-1 `dadba8ec9aeb111f044ca2457736447ef2929809`. The EXE is found at `retail/HOCKEY11.EXE`,
`$NHL97_EXE11` or `../EA-NHL-Disassembly-Project/NHL97-PC/1.1/HOCKEY.EXE`. Every commit must MATCH both versions.

- NASM gets `-dVERSION=10` or `-dVERSION=11`; `src/inc/hockey.inc` defaults to 10.
- What 1.1 changed sits next to the 1.0 code: `%if VERSION = 11` (1.1) `%else` (1.0) `%endif`, or `%if VERSION = 11`
  alone for code and data only 1.1 has. A file's 1.1-only `global`/`extern` lines are in such a block after its
  own lists. Edit both branches when you rename or comment something that is in both.
- `src/segments_v11.txt` places the same files, in the same order, at their 1.1 addresses. Each file keeps its
  1.0 section name `s_<1.0 start>`; the linker matches the sections by position.
- `src/inc/symbols.inc` and `docs/name_map.csv` hold 1.0 addresses. Names only 1.1 has are in
  `docs/name_map_v11.csv` with their 1.1 addresses.
- `tools/names/rename_symbol.py` also builds 1.1 when its EXE is found.
- `tools/build/v11/run.sh HOCKEY10.EXE HOCKEY11.EXE` is the generator that wrote the 1.1 code: it aligns the two
  EXEs, writes and verifies the 1.1 code of each changed routine and variable and puts it in `src/`. It runs on a
  tree without the 1.1 code (before commit "1.1 build option"); names and comments of the 1.1-only labels are in
  `tools/build/v11/names11.py`.

What 1.1 changes: a CPU speed measure that works without rdtsc (`InitVideoModeList` reads the PIT or calls
`EstimateCpuSpeed`; `UpdateScoreClockData` uses it), the GoalieTick rdtsc profiling is gone, the network link
checks the other computer's version (`str_PeerVersionOlder`), speech bank loading, the animation node free list,
and many BSS variables are moved or merged.
