#!/usr/bin/env python3
"""gen_flagops.py - write port/flagops.h: every pushf / popf in object 1 (the SDL2 port traps them, port/emu.c).

  python3 tools/build/gen_flagops.py            (needs tools/lst_index.pkl from tools/build/lst_parse.py and build/parts)

Each instruction the IDA listing shows is checked against the bytes of the code object (9C, 9D, 66 9C, 66 9D)."""
import os, pickle, json
ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
it = pickle.load(open(os.path.join(ROOT, 'tools/lst_index.pkl'), 'rb'))['items']
man = json.load(open(os.path.join(ROOT, 'build/parts/manifest.json')))
img = b''.join(open(os.path.join(ROOT, 'build/parts', s['file']), 'rb').read() for s in man['segments'] if s['obj'] == 1 and s['file'])
K = {'pushf': 0, 'pushfd': 0, 'popf': 1, 'popfd': 1, 'pushfw': 2, 'popfw': 3}
BYTES = {0: b'\x9c', 1: b'\x9d', 2: b'\x66\x9c', 3: b'\x66\x9d'}
out = []
for a, (seg, kind, mn, ops, name) in sorted(it.items()):
    k = K.get(mn.lower()) if seg == 'cseg01' and kind == 'insn' else None
    if k is None: continue
    assert img[a - 0x10000:a - 0x10000 + len(BYTES[k])] == BYTES[k], hex(a)
    out.append('{ 0x%X, %d }' % (a, k))
with open(os.path.join(ROOT, 'port/flagops.h'), 'w') as fo:
    fo.write('/* pushf / popf in object 1 of HOCKEY.EXE (tools/build/gen_flagops.py, from the IDA listing). kind: 0 pushf, 1 popf, 2 pushfw, 3 popfw. */\n')
    for i in range(0, len(out), 4): fo.write(', '.join(out[i:i + 4]) + ',\n')
print(len(out), 'flag instructions')
