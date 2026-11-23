#!/usr/bin/env python3
"""Generate NASM source for the routines and data that NHL 97 patch 1.1 changed.

Inputs (in this folder): hockey10.exe, hockey11.exe, v10info.pkl (align.py), align.pkl (align2/refine/votes).
Output: regions.json with, per changed region, the 1.0 range, the 1.1 range and the 1.1 source lines."""
import os as _os, sys as _sys
REPO = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import pickle, bisect, struct, difflib, json, os, re, subprocess, sys
from collections import Counter, defaultdict
import iced_x86 as X
sys.path.insert(0, _os.path.join(REPO, 'tools')); sys.path.insert(0, _os.path.join(REPO, 'tools/build'))
import link_src as L
from le import load

I = pickle.load(open('v10info.pkl', 'rb'))
fields, syms10, gsym10 = I['fields'], I['syms'], I['gsym']
fpos = [f[0] for f in fields]
d0, h0, o0, g0, img0 = load('hockey10.exe')
d1, h1, o1, g1, img1 = load('hockey11.exe')
OBASE = {1: 0x10000, 2: 0x140000, 3: 0x150000, 4: 0x160000}

def mkget(img, objs):
    def get(a, n):
        for o in objs:
            if o['base'] <= a < o['base'] + o['virtual_size']:
                b = img[o['base']][a - o['base']:a - o['base'] + n]
                return b + bytes(n - len(b))
        raise KeyError(hex(a))
    return get
G0 = mkget(img0, o0); G1 = mkget(img1, o1)
fix1 = {s: (t, to, st) for c, s, t, to, st in g1}
fix1pos = sorted(fix1)
R = pickle.load(open('align.pkl', 'rb'))
chunks = sorted(c for lo in R for c in R[lo])

def mask10(a, b):
    bb = bytearray(G0(a, b - a))
    i = bisect.bisect_left(fpos, a - 3)
    while i < len(fields) and fields[i][0] < b:
        for k in range(fields[i][1]):
            j = fields[i][0] - a + k
            if 0 <= j < len(bb): bb[j] = 0
        i += 1
    return bytes(bb)

def mask11(a, b):
    bb = bytearray(G1(a, b - a))
    i = bisect.bisect_left(fix1pos, a - 3)
    while i < len(fix1pos) and fix1pos[i] < b:
        for k in range(4):
            j = fix1pos[i] - a + k
            if 0 <= j < len(bb): bb[j] = 0
        i += 1
    return bytes(bb)

# ---- regions: spans between consistent boundaries (a changed chunk, an insertion, a deletion or a reordering)
n = len(chunks)
INF = 1 << 40
pre = [0] * (n + 1)      # max 1.1 end of the unchanged chunks before i
for i in range(n):
    a, b, d, ok = chunks[i]
    pre[i + 1] = max(pre[i], b + d if ok else 0)
suf = [INF] * (n + 1)
for i in range(n - 1, -1, -1):
    a, b, d, ok = chunks[i]
    suf[i] = min(suf[i + 1], a + d if ok else INF)
def good(i):              # the boundary before chunk i
    if i == 0 or i == n: return True
    p, q = chunks[i - 1], chunks[i]
    if p[1] != q[0]: return True                                 # object boundary
    if pre[i] > suf[i]: return False                             # something moved across it
    if p[3] and q[3]: return p[1] + p[2] <= q[0] + q[2]          # equal, or an insertion here
    return p[3] or q[3]
def end1(i):   # 1.1 end of chunk i-1's position = start of chunk i in 1.1
    return chunks[i][0] + chunks[i][2] if chunks[i][3] else None
regions = []
i = 0
while i < n:
    j = i + 1
    while j < n and not good(j): j += 1
    span = chunks[i:j]
    a0, b0 = span[0][0], span[-1][1]
    made = len(span) > 1 or not span[0][3]
    if made:
        # 1.1 range: from the end of the previous unchanged chunk to the start of the next one
        a1 = chunks[i - 1][1] + chunks[i - 1][2] if i and chunks[i - 1][3] and chunks[i - 1][1] == a0 else None
        b1 = chunks[j][0] + chunks[j][2] if j < n and chunks[j][3] and chunks[j][0] == b0 else None
        if a1 is None: a1 = a0 + (chunks[i - 1][2] if i else 0)
        if b1 is None: b1 = b0 + (chunks[j - 1][2] if chunks[j - 1][2] is not None else 0)
        regions.append(dict(a0=a0, b0=b0, a1=a1, b1=b1, labels10=sorted(x for x in syms10 if a0 <= x < b0)))
    # an insertion between two unchanged chunks
    if not made and j < n and chunks[j - 1][1] == chunks[j][0] and chunks[j - 1][3] and chunks[j][3] and chunks[j - 1][2] != chunks[j][2] and good(j):
        x = chunks[j][0]
        regions.append(dict(a0=x, b0=x, a1=x + chunks[j - 1][2], b1=x + chunks[j][2], labels10=[]))
    i = j
regions.sort(key=lambda r: (r['a0'], r['b0']))
regions = [r for r in regions if not (r['a0'] == r['b0'] and any(q is not r and q['a0'] < q['b0'] and q['a1'] < r['b1'] and r['a1'] < q['b1'] for q in regions))]
# ---- 1.1 addresses of 1.0 labels: unchanged chunks shift; changed regions by votes and by a diff inside the region
unch = [(a + d, b + d, d) for a, b, d, ok in chunks if ok]
ustart = [u[0] for u in unch]
votes = defaultdict(Counter)
cstart = [c[0] for c in chunks]
for P, sz, k, T in fields:
    ci = bisect.bisect_right(cstart, P) - 1; a, b, d, ok = chunks[ci]
    if not ok: continue
    P1 = P + d
    if k == 'a':
        f = fix1.get(P1)
        if not f: continue
        got = OBASE[f[0]] + f[1]
    else:
        v = G1(P1, sz); got = P1 + sz + (struct.unpack('<i', v)[0] if sz == 4 else struct.unpack('<b', v)[0])
    votes[T][got] += 1

names11 = {}       # 1.1 address -> name, inside changed regions
aliases11 = {}     # 1.1 address -> more 1.0 names placed at the same address (variables 1.1 merged)
for r in regions:
    place = {}
    sm = difflib.SequenceMatcher(None, mask10(r['a0'], r['b0']), mask11(r['a1'], r['b1']), autojunk=False)
    blocks = [b for b in sm.get_matching_blocks() if b[2] >= 6]
    inner = {c[0]: c[0] + c[2] for c in chunks if c[3] and r['a0'] <= c[0] < r['b0']}
    for x in r['labels10']:
        if x in votes and len(votes[x]) == 1 or (x in votes and x not in inner):
            place[x] = votes[x].most_common(1)[0][0]; continue
        if x in inner: place[x] = inner[x]; continue
        ci = bisect.bisect_right(cstart, x) - 1
        if chunks[ci][3] and chunks[ci][0] >= r['a0']: place[x] = x + chunks[ci][2]; continue
        if x in votes: place[x] = votes[x].most_common(1)[0][0]; continue
        off = x - r['a0']
        for (p, q, n) in blocks:
            if p <= off < p + n: place[x] = r['a1'] + q + (off - p); break
    if r['a0'] < r['b0'] and r['a0'] not in place: place[r['a0']] = r['a1']
    r['place'] = place
    for x, x1 in place.items():
        nm = [n for n in syms10[x] if '.' not in n] or syms10[x]
        if x1 in names11 and names11[x1] != nm[0] and '.' not in nm[0] and '.' not in names11[x1]: aliases11.setdefault(x1, []).append(nm[0])
        names11.setdefault(x1, nm[0])

# a region must stay inside one source file: split at file starts
segstarts = sorted(sg['start'] for sg in I['segs'])
split = []
for r in regions:
    cuts = [S for S in segstarts if r['a0'] < S < r['b0']]
    cur = r
    for S in cuts:
        S1 = cur['place'].get(S)
        PAD = set(b'\x90\x8d\x40\x00\x8b\xc0')
        if S1 is None and all(c in PAD for c in G0(S, cur['b0'] - S)):
            S1 = cur['b1']
            while S1 > cur['a1'] and G1(S1 - 1, 1)[0] in PAD: S1 -= 1
        if S1 is None:
            nx = [x for x in sorted(cur['place']) if x >= S]
            if nx and all(c in PAD for c in G0(S, nx[0] - S)):
                S1 = cur['place'][nx[0]]
                while S1 > cur['a1'] and G1(S1 - 1, 1)[0] in PAD and G1(S1 - 1, 1)[0] != 0xC3: S1 -= 1
        if S1 is None and mask10(cur['a0'], S) == mask11(cur['a1'], cur['a1'] + S - cur['a0']): S1 = cur['a1'] + S - cur['a0']
        assert S1 is not None, 'cannot split region %X-%X at %X' % (cur['a0'], cur['b0'], S)
        left = dict(a0=cur['a0'], b0=S, a1=cur['a1'], b1=S1, labels10=[x for x in cur['labels10'] if x < S],
                    place={x: y for x, y in cur['place'].items() if x < S})
        cur = dict(a0=S, b0=cur['b0'], a1=S1, b1=cur['b1'], labels10=[x for x in cur['labels10'] if x >= S],
                   place={x: y for x, y in cur['place'].items() if x >= S})
        split.append(left)
    split.append(cur)
regions = split

def name_of(T1, here_region=None, size=None):
    """symbol expression for a 1.1 address"""
    # in a changed region?
    for r in regions:
        if r['a1'] <= T1 < r['b1'] or (T1 == r['b1'] and False):
            return ('R', r, T1)
    i = bisect.bisect_right(ustart, T1) - 1
    if i >= 0 and (T1 < unch[i][1] or (T1 == unch[i][1])):
        a1, b1, d = unch[i]
        T0 = T1 - d
        if T0 in syms10:
            nm = [n for n in syms10[T0] if not n.split('.')[-1].isdigit()] or syms10[T0]
            return ('S', nm[0])
        k = bisect.bisect_right(sorted_syms10, T0) - 1
        base = sorted_syms10[k]
        nm = [n for n in syms10[base] if not n.split('.')[-1].isdigit()] or syms10[base]
        return ('S', '%s+%s' % (nm[0], hexs(T0 - base)))
    return None
sorted_syms10 = sorted(syms10)

def hexs(v):
    if v < 10: return str(v)
    s = '%Xh' % v
    return ('0' + s) if s[0] in 'ABCDEF' else s

pickle.dump(dict(regions=regions, names11=names11, unch=unch), open('regions.pkl', 'wb'))
if __name__ == '__main__':
    tot = 0
    for r in regions:
        miss = [x for x in r['labels10'] if x not in r['place']]
        tot += len(miss)
        print('%X-%X -> %X-%X  labels %d placed %d %s' % (r['a0'], r['b0'], r['a1'], r['b1'], len(r['labels10']), len(r['place']),
              ' '.join(syms10[x][0] for x in miss[:6])))
    print('unplaced labels', tot)
