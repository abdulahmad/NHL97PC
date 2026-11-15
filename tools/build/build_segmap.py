#!/usr/bin/env python3
"""build_segmap.py - write segmap97pc.json: the segment (module) layout of the 96 PC objects (maintainer tool).

  python3 tools/build/build_segmap.py build/f97.pkl tools/names/match96.csv

Code object: the proven atoms of tools/build/module_atoms.py are grouped into segments.
  * An atom whose matched functions come from one NHL96PC module (tools/names/match96.csv) takes that module's path (engine/collide/collide.asm),
    so 97 keeps the 96 layout. A short run with another label inside a module is absorbed (provisional).
  * HAND names the segments that have no 96 counterpart but one clear theme; every other unmatched stretch is a
    placeholder named by its start address (front_<ADDR>, engine_<ADDR>, lib_<ADDR>) until the segment agent names it.
  * Library zone: runs of the same 96 library module, numbered in 97 link order.
Data objects: a cut where the owning code segment of the data changes (data follows the link order of the code).
The boundaries are provisional module boundaries, not a proven object-file split (see docs/PLAN.md)."""
import os, sys, json, pickle, re, bisect
from collections import Counter, defaultdict
HERE = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, HERE); sys.path.insert(0, os.path.dirname(HERE))
import paths
from module_atoms import atoms
ROOT = paths.ROOT

# NHL 97 PC zones (provisional, from the NHL96PC matches and the code itself):
#   0x10000-0x11504 front (controller / joystick set-up), 0x11504-0x3E818 the game engine (NHL96PC engine modules
#   match here, in the same order), 0x3E818-0xF94BC the front end (menus; mostly unaligned functions),
#   0xF94BC- the library zone (EA gfx / file / timer libraries, sound drivers, Watcom C library)
ENGINE = (0x11504, 0x3E818)
LIB0 = 0xF94BC
# start of atom -> (path under src/, note). Only segments with one clear theme; the rest stay placeholders.
HAND = {
 0x10010: ('front/front_10010', 'placeholder'),
 0x7D059: ('front/main/main', 'holds main_ (FLIRT)'),
 0x2DE3C: ('engine/engine_2DE3C', 'placeholder'),     # NHL96PC collide, faceoff, hockey and input routines mixed
}

def main():
    f96, mcsv = sys.argv[1], sys.argv[2]
    AT = atoms(f96, mcsv)
    b = pickle.load(open(f96, 'rb')); objs = b['objs']; F = b['funcs']
    cb, cv, _ = objs[1]; CE = cb + cv
    # library zone: from the first atom after the last game module
    lib0 = next(a['start'] for a in AT if a['start'] >= LIB0)
    def label(a):
        if not a['mods']: return None
        m, n = a['mods'].most_common(1)[0]
        size = a['end'] - a['start']
        if a['start'] >= lib0:
            return re.sub(r'_\d+$', '', m)
        if not (ENGINE[0] <= a['start'] < ENGINE[1]): return None
        if not m.startswith('engine/'): return None
        return m if n * 4 >= size else None
    labs = [label(a) for a in AT]
    # absorb short runs of another label that sit inside one module
    runs = []
    for i, l in enumerate(labs):
        if l is None: continue
        if runs and runs[-1][0] == l: runs[-1][2] = i; runs[-1][3] += sum(AT[i]['mods'].values())
        else: runs.append([l, i, i, sum(AT[i]['mods'].values())])
    for k, (l, i0, i1, nb) in enumerate(runs):
        small = nb < (0x800 if AT[i0]['start'] < lib0 else 0x60)
        if small and 0 < k < len(runs) - 1 and runs[k - 1][0] == runs[k + 1][0]:
            for i in range(i0, i1 + 1): labs[i] = runs[k - 1][0]
            runs[k][0] = runs[k - 1][0]
        elif small and k > 0 and AT[i0]['start'] < lib0:
            for i in range(i0, i1 + 1): labs[i] = runs[k - 1][0]
            runs[k][0] = runs[k - 1][0]
    segs = []      # [start, path, note]
    cur = None
    for a, l in zip(AT, labs):
        st = a['start']
        zone = 'lib' if st >= lib0 else ('engine' if ENGINE[0] <= st < ENGINE[1] else 'front')
        if st in HAND:
            segs.append([st, HAND[st][0], HAND[st][1]]); cur = ('hand', HAND[st][0]); continue
        if st == lib0 and l is None: segs.append([st, 'lib/lib_%05X' % st, 'placeholder']); cur = ('ph', None); continue
        if l is not None and zone == 'lib' and not l.startswith('lib/'):
            # a NHL96PC front module (or a NHL96PC placeholder) matched inside the library zone: library code there
            l = cur[1] if cur and cur[0] == '95' and re.match(r'lib/lib_[0-9A-F]+$', cur[1] or '') else 'lib/lib_%05X' % st
        elif l is not None and re.match(r'lib/lib_[0-9A-F]+$', l):
            l = cur[1] if cur and cur[0] == '95' and re.match(r'lib/lib_[0-9A-F]+$', cur[1] or '') else 'lib/lib_%05X' % st
        if l is not None:
            if cur != ('95', l): segs.append([st, l, 'NHL96PC module (matched functions)']); cur = ('95', l)
            continue
        if a['end'] - a['start'] >= 0x1000 and zone != 'lib':
            segs.append([st, '%s/%s_%05X' % (zone, zone, st), 'placeholder']); cur = ('ph', st)
    segs[0][0] = cb if segs[0][0] > cb else segs[0][0]
    if segs[0][0] != cb: segs.insert(0, [cb, 'lib/watcom/watcom_begtext', ''])
    # unique paths: a module that comes back later gets _2, _3 (library slices are numbered _01, _02 ...)
    seen = Counter(); total = Counter(s[1] for s in segs)
    for s in segs:
        p = s[1]; seen[p] += 1
        if p.startswith('lib/') and total[p] > 1: s[1] = '%s_%02d' % (p, seen[p])
        elif seen[p] > 1: s[1] = '%s_%d' % (p, seen[p])
    SM = json.load(open(os.path.join(ROOT, 'segmap97pc.json')))
    code = []
    for k, (st, p, note) in enumerate(segs):
        en = segs[k + 1][0] if k + 1 < len(segs) else CE
        code.append(dict(start=st, end=en, module=p.split('/')[-1], obj=1, file=p + '.asm', note=note))
    SM['cseg01'] = code
    # ---- data: cut where the owning code segment changes
    cst = [c['start'] for c in code]
    owner = defaultdict(set)
    for f in F:
        k = bisect.bisect_right(cst, f['start']) - 1
        for _, t in f['refs']:
            if not (cb <= t < CE): owner[t].add(k)
    for oname, on in (('cseg02', 2), ('dseg03', 3)):
        ob, ov, _ = objs[on]
        SM[oname] = [dict(start=ob, end=ob + ov, module=oname, obj=on, file='%s/%s.asm' % (oname, oname), note='')]
    ob, ov, oimg = objs[4]; phys = ob + len(oimg)
    labs4 = sorted(t for t in owner if ob <= t < ob + ov)
    own = [(t, next(iter(owner[t])) if len(owner[t]) == 1 else None) for t in labs4]
    cuts = [(ob, None)]
    i = 0; curo = None
    while i < len(own):
        t, o = own[i]
        if o is not None and o != curo:
            # the new owner must hold for a while: 4 of the next 6 owned labels, and the cut needs 0x100 bytes of room
            nxt = [x for _, x in own[i:i + 12] if x is not None][:6]
            if nxt.count(o) >= min(4, len(nxt)) and t - cuts[-1][0] >= 0x100:
                cuts.append((t, o)); curo = o
        i += 1
    # initialised data and BSS never share a file; a fixup dword that straddles the end of the file data stays whole
    for ln in open(os.path.join(ROOT, 'build/parts/le_fixups.tsv')):
        if not ln.startswith('#'):
            src = int(ln.split()[1], 16)
            if src < phys < src + 4: phys = src + 4
    if not any(c[0] == phys for c in cuts):
        cuts = sorted(cuts + [(phys, None)])
    data = []; seen = Counter()
    for k, (st, o) in enumerate(cuts):
        en = cuts[k + 1][0] if k + 1 < len(cuts) else ob + ov
        if o is None: o = next((x for s_, x in reversed(cuts[:k]) if x is not None), None) if st != ob else None
        base = code[o]['file'][:-4] if o is not None else 'shared'
        parts = base.split('/'); stem = parts[-1]; folder = '/'.join(parts[:-2] if len(parts) > 2 and parts[-2] == re.sub(r'_\d+$', '', stem) else parts[:-1])
        kind = 'bss' if st >= phys else 'data'
        key = (folder, stem, kind); seen[key] += 1
        data.append(dict(start=st, end=en, module='%s_%s_%02d' % (stem, kind, seen[key]), obj=4,
                         file='data/%s%s_%s_%02d.asm' % (folder + '/' if folder else '', stem, kind, seen[key]), note='owner: ' + (code[o]['file'] if o is not None else 'shared')))
    SM['dseg04'] = data
    json.dump(SM, open(os.path.join(ROOT, 'segmap97pc.json'), 'w'), indent=1)
    print('code segments', len(code), 'data segments', len(data), 'library zone from %05X' % lib0)
    c = Counter(('placeholder' if s['note'] == 'placeholder' else ('96PC' if s['note'].startswith('NHL96PC') else 'named')) for s in code)
    print(dict(c), 'placeholder bytes', sum(s['end'] - s['start'] for s in code if s['note'] == 'placeholder'))

if __name__ == '__main__':
    main()
