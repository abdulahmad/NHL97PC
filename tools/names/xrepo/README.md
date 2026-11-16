# Cross-repo name carriers

Carry names between the PC disassemblies (run from the folder that holds both clones, e.g. `NHL96PC` and `nhl97pc`).
Each prints `OLD_label  NEW_name  votes  total` (TSV); `mkb.py` turns unanimous rows into a `rename_symbol.py --batch` file.

- `xmatch.py --mask OLD NEW`: code blocks with identical instructions (numbers masked, symbol+offset folded); block
  starts and aligned operands vote. Same-named routines are also aligned with difflib.
- `xfuzzy.py OLD NEW`: generic OLD blocks with no exact twin, against the most similar NEW block (ratio, runner-up).
- `xtab.py OLD NEW`: `dd` tables with the same label in both, entry by entry.
- `xcall.py OLD NEW`: call order of same-named routines; check votes against body similarity before use.
- `xdata.py OLD NEW`: data labels in file order by content, kept when the content is unique or a named routine uses both.
- `mkb.py OLDREPO NEWREPO OUT TSV...`: the batch, with NEW's descriptions (lineage-free) as evidence.

Rerun after each applied batch: new names let more blocks align.
