#!/usr/bin/env python3
"""Put the emitted 1.1 regions into src/ next to the 1.0 code, behind %if VERSION = 11, and write src/segments_v11.txt."""
import os as _os, sys as _sys
REPO = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, os, re, pickle, bisect, json
sys.path.insert(0, _os.path.join(REPO, 'tools/build')); sys.path.insert(0, _os.path.join(REPO, 'tools'))
import asmaddr
ROOT = REPO
E = pickle.load(open('emitted.pkl', 'rb'))
import gen11 as G
segs = G.I['segs']
LABEL = re.compile(r'^([A-Za-z_.][\w.$?@]*):')
REGS = set('eax ebx ecx edx esi edi ebp esp ax bx cx dx si di bp sp al bl cl dl ah bh ch dh cs ds es fs gs ss st0 st1 st2 st3 st4 st5 st6 st7 st'.split())
KW = set('byte word dword qword tword short near far nosplit LD rep repe repne repz repnz lock strict to wrt gotoff resb db dd dw dq times'.split())

def seg_of(r):
    a0 = r['a0']
    if r['a0'] == r['b0']:
        c = [s for s in segs if s['start'] < a0 <= s['end']]
    else:
        c = [s for s in segs if s['start'] <= a0 < s['end']]
    assert len(c) == 1, hex(a0)
    s = c[0]
    assert r['b0'] <= s['end'], 'region %X-%X crosses %s' % (r['a0'], r['b0'], s['src'])
    return s

byfile = {}
for a1, r in E.items():
    s = seg_of(r); r['seg'] = s
    byfile.setdefault(s['src'], []).append(r)

def positions(path, seg):
    lines = open(path).read().split('\n')
    ad = asmaddr.addrs(path)
    pos = [None] * len(lines)
    nxt = seg['end']
    for i in range(len(lines) - 1, -1, -1):
        if i in ad: nxt = ad[i]
        pos[i] = ad.get(i, nxt)
    return lines, pos, ad

def is_code_line(l):
    s = l.strip()
    return s and not s.startswith(';')

def start_index(lines, pos, ad, a):
    for i, l in enumerate(lines):
        if pos[i] == a and (i in ad or LABEL.match(l)): return i
    raise ValueError('no line at %X' % a)

def end_index(lines, pos, ad, b, seg):
    if b == seg['end']:
        i = len(lines)
        while i > 0 and not lines[i - 1].strip(): i -= 1
        return i
    i = start_index(lines, pos, ad, b)
    while i > 0 and (lines[i - 1].lstrip().startswith(';') or not lines[i - 1].strip()) and not lines[i - 1].startswith('%'): i -= 1
    return i

def label_comment(lines, name):
    """the comment on a 1.0 data label's line plus its continuation lines"""
    for i, l in enumerate(lines):
        m = LABEL.match(l)
        if m and m.group(1) == name:
            rest = l[len(name) + 1:]
            if ';' not in rest: return []
            out = [rest[rest.index(';'):].strip()]
            for l2 in lines[i + 1:]:
                if re.match(r'^ {20,}; ', l2): out.append(l2.strip())
                else: break
            return out
    return []

def header10(lines, name):
    """the routine header above a 1.0 label (rule line, name line, description, rule line)"""
    for i, l in enumerate(lines):
        m = LABEL.match(l)
        if m and m.group(1) == name:
            c = i
            while c > 0 and lines[c - 1].startswith((';', '%')) and not lines[c - 1].startswith(RULE): c -= 1
            if c > 0 and lines[c - 1].startswith(RULE):
                b = c - 2
                while b > 0 and not lines[b].startswith(RULE): b -= 1
                return [x for x in lines[b:c] if not x.startswith('%')]
            return None
    return None

RULE = ';' + '-' * 77
from names11 import RENAME, DATA_COMMENT, HEADER
RENAME_RE = re.compile(r'(?<![\w.])(' + '|'.join(sorted(map(re.escape, RENAME), key=len, reverse=True)) + r')(?![\w])')
def ren(t): return RENAME_RE.sub(lambda m: RENAME[m.group(1)] or m.group(1), t)
def wrapc(text):
    """a data comment wrapped to the 110-column limit (comment at column 48)"""
    import textwrap
    w = textwrap.wrap(text[2:], 60)
    return ['; ' + x for x in w]

def operand_words(t):
    code = t.split(';')[0].strip()
    w = code.split(None, 1)
    while w and w[0] in ('rep', 'repe', 'repne', 'repz', 'repnz', 'lock', 'o16', 'o32', 'a16', 'a32'):
        w = w[1].split(None, 1) if len(w) > 1 else []
    if not w: return []
    rest = w[1] if len(w) > 1 else ''
    if w[0] == 'LD': rest = rest.split(',', 1)[1] if ',' in rest else ''
    if w[0] in ('db', 'dw', 'resb', 'resw', 'resd', 'times'): return []
    return re.findall(r'(?<![\w.])([A-Za-z_][\w.$?@]*)', rest)

report = []
newglobals_all = {}
for src, regs in sorted(byfile.items()):
    path = os.path.join(ROOT, 'src', src)
    seg = regs[0]['seg']
    lines, pos, ad = positions(path, seg)
    defined10 = set()
    for l in lines:
        m = LABEL.match(l)
        if m and not m.group(1).startswith('.'): defined10.add(m.group(1))
    globals10 = set()
    for l in lines:
        if l.startswith('global '): globals10.update(x.strip() for x in l[7:].split(','))
    externs10 = set()
    for l in lines:
        if l.startswith('extern '): externs10.update(x.strip() for x in l[7:].split(','))
    edits = []   # (start, end, newtext lines)
    defined11 = set(); refs11 = set()
    for r in sorted(regs, key=lambda r: r['a0']):
        body = []
        for (p, n, t, k) in r['lines']:
            if k == 'label':
                nm0 = t[:-1]
                if nm0 in RENAME and RENAME[nm0] is None: continue      # a padding label: no name
                nm = ren(nm0); t = nm + ':'
                if not nm.startswith('.') and '.' not in nm: defined11.add(nm)
                if r.get('data'):
                    c = wrapc(DATA_COMMENT[nm]) if nm in DATA_COMMENT else label_comment(lines, nm0)
                    if c:
                        body.append(('%-48s%s' % (t, c[0])).rstrip())
                        body += [' ' * 48 + x for x in c[1:]]
                    else: body.append(t)
                else:
                    h = None
                    if nm in HEADER: h = [RULE, '; %-46s%X  97 PC 1.1' % (nm, p)] + ['; ' + x for x in HEADER[nm]] + [RULE]
                    elif '.' not in nm:
                        h = header10(lines, nm0)
                        if h: h = [h[0], re.sub(r'^(; \S+\s+)[0-9A-F]{5,6}\b', lambda m: m.group(1) + '%X' % p, h[1])] + h[2:]
                    if h: body += h
                    body.append(t)
            else:
                t = ren(t)
                body.append('        ' + t)
                for w in operand_words(t):
                    if w in REGS or w in KW or re.fullmatch(r'[0-9A-F]+h', w): continue
                    refs11.add(w)
        if r['a0'] == r['b0']:
            i = end_index(lines, pos, ad, r['a0'], seg) if r['a0'] < seg['end'] else end_index(lines, pos, ad, seg['end'], seg)
            edits.append((i, i, ['%if VERSION = 11'] + body + ['%endif']))
        else:
            i = start_index(lines, pos, ad, r['a0'])
            if i > 0 and lines[i - 1].startswith(RULE) and not r.get('data'):     # take the routine header in too
                b = i - 2
                while b > 0 and not lines[b].startswith(RULE): b -= 1
                i = b
            j = end_index(lines, pos, ad, r['b0'], seg)
            edits.append((i, j, ['%if VERSION = 11'] + body + ['%else'] + lines[i:j] + ['%endif']))
        report.append('%s %X-%X -> %X-%X' % (src, r['a0'], r['b0'], r['a1'], r['b1']))
    for i, j, new in sorted(edits, reverse=True):
        lines[i:j] = new
    # declarations for 1.1
    defined_all = defined10 | defined11
    ext = sorted(w for w in refs11 if w not in defined_all and w.split('.')[0] not in defined_all and w not in externs10)
    glob = sorted(w for w in defined11 if w not in globals10)
    newglobals_all[src] = glob
    decl = []
    if ext or glob:
        decl = ['%if VERSION = 11']
        for k in range(0, len(glob), 8): decl.append('global ' + ', '.join(glob[k:k + 8]))
        for k in range(0, len(ext), 8): decl.append('extern ' + ', '.join(ext[k:k + 8]))
        decl.append('%endif')
        last = max(i for i, l in enumerate(lines[:400]) if l.startswith('extern ') or l.startswith('global ') or l.startswith('section '))
        lines[last + 1:last + 1] = decl
    open(path, 'w').write('\n'.join(lines))
print('\n'.join(report))

# ---- 1.1 layout
unch = [(a, b, d) for a, b, d, ok in G.chunks if ok]
def start11(S):
    for r in G.regions:
        if r['a0'] == S and r['a0'] < r['b0']: return r['a1']
    k = bisect.bisect_right([c[0] for c in G.chunks], S) - 1
    a, b, d, ok = G.chunks[k]
    assert ok, 'segment start %X inside a changed chunk' % S
    return S + d
o1 = {o['base']: o for o in G.o1}
lps1 = G.h1['last_page_size']
out = ['# NHL 97 PC 1.1 HOCKEY.EXE segment layout: the files of src/segments.txt (same order), placed for patch 1.1.',
       '# Generated with the 1.1 code (tools/build/v11/); built by ./build.sh 11. The section of each file keeps its 1.0 name s_<1.0 start>.',
       '# object start end initialised_bytes module source (relative to src/)']
starts = [start11(s['start']) for s in segs]
for k, s in enumerate(segs):
    obase = [b for b in G.OBASE.values() if b <= s['start']][-1]
    o = o1[obase]
    if k + 1 < len(segs) and segs[k + 1]['obj'] == s['obj']: e = starts[k + 1]
    else: e = obase + o['virtual_size']
    last = obase == max(G.OBASE.values())
    phys = obase + (o['page_count'] - 1) * 4096 + (lps1 if last else 4096)
    nb = 0 if s['bytes'] == 0 else max(0, min(e, phys) - starts[k])
    out.append('%d %X %X %d %s %s' % (s['obj'], starts[k], e, nb, s['module'], s['src']))
open(os.path.join(ROOT, 'src/segments_v11.txt'), 'w').write('\n'.join(out) + '\n')
json.dump(newglobals_all, open('newglobals.json', 'w'), indent=1)
