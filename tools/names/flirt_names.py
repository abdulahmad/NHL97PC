#!/usr/bin/env python3
"""flirt_names.py - start docs/name_map.csv from the library names of the FLIRT IDA listing (maintainer tool, bootstrap).

  python3 tools/build/lst_parse.py ../EA-NHL-Disassembly-Project/NHL97-PC/lstwithflirt/HOCKEY.EXE.lst tools/lst_index.pkl
  python3 tools/names/flirt_names.py            (writes docs/name_map.csv: FLIRT rows only; then import_match96.py, import_match95.py)

Takes every proc / collapsed function the listing names (Watcom wa32rtd / wa32rt_ signatures), except IDA's own placeholders
(sub_, nullsub_, unknown_libname_, j_) and names that are not identifiers. Only from 0xF9000 up (the library zone) plus main_:
the few FLIRT hits inside the game code are false matches."""
import csv, os, pickle, re
ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
HDR = 'address,name,auto_name,source,confidence,evidence,file'.split(',')
d = pickle.load(open(os.path.join(ROOT, 'tools/lst_index.pkl'), 'rb'))
rows, used = [], set()
for f in d['funcs']:
    n = f['name']
    if re.match(r'(sub_|nullsub_|unknown_libname|j_)', n) or not re.fullmatch(r'[A-Za-z_?@$][\w?@$]*', n): continue
    if (f['start'] < 0xF9000 and n != 'main_') or n in used: continue
    used.add(n)
    rows.append(dict(address='%05X' % f['start'], name=n, auto_name='', source='WATCOM', confidence='high',
                     evidence='IDA FLIRT library signature (wa32rtd/wa32rt_)', file=''))
with open(os.path.join(ROOT, 'docs/name_map.csv'), 'w', newline='') as fo:
    w = csv.DictWriter(fo, HDR); w.writeheader(); w.writerows(sorted(rows, key=lambda r: int(r['address'], 16)))
print(len(rows), 'FLIRT names')
