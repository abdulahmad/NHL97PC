#!/usr/bin/env python3
"""Emit verified NASM lines for each changed 1.1 code region (uses gen11)."""
import os as _os, sys as _sys
REPO = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, os, re, struct, subprocess, bisect, json, pickle, tempfile
import iced_x86 as X
import gen11 as Gn
from gen11 import G1, fix1, regions, names11, hexs, syms10

FMT = X.Formatter(X.FormatterSyntax.NASM)
FMT.uppercase_hex = True; FMT.hex_prefix = ''; FMT.hex_suffix = 'h'; FMT.add_leading_zero_to_hex_numbers = True
FMT.small_hex_numbers_in_decimal = True; FMT.nasm_show_sign_extended_immediate_size = True
FMT.space_after_operand_separator = True; FMT.show_branch_size = False
FMT.memory_size_options = X.MemorySizeOptions.ALWAYS
SENT = 0x0F5E0000
REGION_OF = {}

def region_for(T1):
    for r in regions:
        if r['a1'] <= T1 < r['b1']: return r
    return None

def clean(n):
    return n

class Region:
    def __init__(self, r):
        self.r = r; self.a, self.b = r['a1'], r['b1']
        self.items = []    # (addr, kind, data)
        self.globals = {}  # addr -> name (global labels in 1.1 region)
        self.local = {}    # addr -> local label name '.N' and owner
        for x1, nm in names11.items():
            if self.a <= x1 < self.b and '.' not in nm: self.globals[x1] = nm
        self.data = self.a >= 0x140000
        if self.a not in self.globals and not self.data:
            if self.r['a0'] in Gn.syms10 or self.r['a0'] == self.r['b0'] or not all(c in (0x90, 0x8D, 0x40, 0x00, 0x8B, 0xC0) for c in G1(self.a, self.b - self.a)):
                self.globals[self.a] = names11.get(self.a) or ('NEW_%X' % self.a)
            else:
                self.globals[self.a] = None      # padding at the start of a file: no label

    def decode(self):
        if self.data: self.out = []; self.starts = set(); self.owner_of = {}; return
        p = self.a; out = []
        targets = set()
        while p < self.b:
            f = fix1.get(p)
            if f and f[2] == 7:
                T = Gn.OBASE[f[0]] + f[1]; out.append((p, 'dd', T, 4)); targets.add(T); p += 4; continue
            raw = bytearray(G1(p, min(16, self.b - p) if self.b - p > 0 else 1))
            dec = X.Decoder(32, bytes(raw), ip=p)
            ins = dec.decode()
            if ins.code == X.Code.INVALID or p + ins.len > self.b:
                out.append((p, 'db', raw[0], 1)); p += 1; continue
            # a fixup that starts inside a later instruction boundary is fine; one that crosses the end is not
            out.append((p, 'ins', ins, ins.len))
            if ins.flow_control in (X.FlowControl.UNCONDITIONAL_BRANCH, X.FlowControl.CONDITIONAL_BRANCH, X.FlowControl.CALL) and ins.op0_kind in (X.OpKind.NEAR_BRANCH32, X.OpKind.NEAR_BRANCH16):
                targets.add(ins.near_branch_target)
            for k in range(p, p + ins.len):
                f2 = fix1.get(k)
                if f2: targets.add(Gn.OBASE[f2[0]] + f2[1])
            p += ins.len
        self.out = out
        self.targets = targets
        return
    def assign(self, alltargets):
        out = self.out
        targets = {t for t in alltargets if self.a <= t < self.b}
        starts = {it[0] for it in out}
        # padding after ret/jmp: keep it as db when nothing jumps to it
        # labels: globals already; local labels for internal targets
        self.owner_of = {}
        # owners: the global labels in order
        gl = sorted(self.globals)
        def owner_at(t):
            k = bisect.bisect_right(gl, t) - 1
            return self.globals[gl[max(k, 0)]]
        # 1.0 local labels placed in 1.1 keep their numbers (only on instruction starts, same owner)
        used = {}
        for x1, nm in names11.items():
            if self.a <= x1 < self.b and '.' in nm and x1 in starts and x1 not in self.globals:
                ow, num = nm.rsplit('.', 1)
                if ow == owner_at(x1) and num.isdigit():
                    self.local[x1] = (ow, '.' + num); used.setdefault(ow, set()).add(int(num))
        nxt = {ow: max(v) for ow, v in used.items()}
        for t in sorted(t for t in targets if self.a <= t < self.b):
            if t in self.globals or t in self.local or t not in starts: continue
            ow = owner_at(t)
            nxt[ow] = nxt.get(ow, 0) + 1
            while nxt[ow] in used.get(ow, ()): nxt[ow] += 1
            self.local[t] = (ow, '.%d' % nxt[ow])
        self.starts = starts

    def label_at(self, T, from_owner):
        if T in self.globals: return self.globals[T]
        if T in self.local:
            ow, ln = self.local[T]
            return ln if ow == from_owner else ow + ln
        if self.data and T not in self.globals:
            self.globals[T] = NEWNAMES.get(T) or ('NEWD_%X' % T)
            return self.globals[T]
        # nearest global/local label below
        cands = [x for x in list(self.globals) + list(self.local) if x <= T]
        x = max(cands)
        base = self.label_at(x, from_owner)
        return '%s+%s' % (base, hexs(T - x))

ALLREG = {}
NEWNAMES = {}

def sym(T, from_reg, from_owner):
    r = region_for(T)
    if r is not None:
        R = ALLREG[r['a1']]
        if R is from_reg: return R.label_at(T, from_owner)
        return R.label_at(T, None)
    s = Gn.name_of(T)
    if s is None:
        # one past the end of an object
        for b, o in zip(Gn.OBASE.values(), Gn.o1):
            if T == b + o['virtual_size']:
                pass
        raise ValueError('no name for %X' % T)
    return s[1]

DISP_SIZE_RE = re.compile(r'\[([^\]]*)\]')

def fmt_ins(R, p, ins, owner, variant):
    """text for one instruction; variant picks an alternative spelling"""
    n = ins.len
    raw = bytearray(G1(p, n))
    subs = {}
    k = 0
    for q in range(p, p + n):
        f = fix1.get(q)
        if f:
            T = Gn.OBASE[f[0]] + f[1]
            v = SENT + k; k += 1
            struct.pack_into('<I', raw, q - p, v)
            subs[v] = sym(T, R, owner)
    ins2 = X.Decoder(32, bytes(raw), ip=p).decode()
    fc = ins2.flow_control
    mn = FMT.format_mnemonic(ins2, X.FormatMnemonicOptions.NO_PREFIXES)
    pref = FMT.format_mnemonic(ins2, X.FormatMnemonicOptions.NONE)
    if ins2.op_count == 1 and ins2.op0_kind in (X.OpKind.NEAR_BRANCH32, X.OpKind.NEAR_BRANCH16):
        t = sym(ins2.near_branch_target, R, owner)
        if fc == X.FlowControl.CALL: return '%s %s' % (mn, t)
        if mn.startswith('loop') or mn in ('jecxz', 'jcxz'): return '%s %s' % (mn, t)
        size = 'short' if n == 2 else 'near'
        return '%s %s %s' % (mn, size, t)
    txt = FMT.format(ins2)
    def rep(m):
        v = int(m.group(1), 16)
        return subs.get(v, m.group(0))
    txt = re.sub(r'\b0?([0-9A-F]{8})h\b', rep, txt)
    # displacement size keyword when there is a base or index register
    if ins2.op_count and any(ins2.op_kind(i) == X.OpKind.MEMORY for i in range(ins2.op_count)):
        has_reg = ins2.memory_base != X.Register.NONE or ins2.memory_index != X.Register.NONE
        ds = ins2.memory_displ_size
        def addsz(m):
            inner = m.group(1)
            if not (variant & 1) and has_reg and ds:
                kw = 'byte ' if ds == 1 else 'dword '
                if ins2.memory_displacement == 0 and '+' not in inner and '-' not in inner: inner = inner + '+0'
                inner = re.sub(r'([+-])(\d+|0?[0-9A-F]+h)$', lambda m: m.group(1) + '0%Xh' % (int(m.group(2)[:-1], 16) if m.group(2).endswith('h') else int(m.group(2))), inner)
                return '[' + kw + inner + ']'
            if variant & 2 and ins2.memory_base == X.Register.NONE and ins2.memory_index != X.Register.NONE:
                return '[nosplit ' + inner + ']'
            return '[' + inner + ']'
        txt = DISP_SIZE_RE.sub(addsz, txt, count=1)
    if variant & 4:
        # load form of reg,reg
        parts = txt.split(None, 1)
        if len(parts) == 2 and ',' in parts[1] and '[' not in parts[1]:
            a, b = [s.strip() for s in parts[1].split(',', 1)]
            txt = 'LD %s, %s, %s' % (parts[0], a, b)
    return txt

def build_lines(R, variants):
    lines = []     # (addr, len, text, kind)
    owner = R.globals[R.a] or 'PAD'
    prev_flow_end = False
    for (p, kind, v, n) in R.out:
        if p in R.globals and R.globals[p] is None:
            pass
        elif p in R.globals:
            owner = R.globals[p]
            for al in Gn.aliases11.get(p, []): lines.append((p, 0, '%s:' % al, 'label'))
            lines.append((p, 0, '%s:' % owner, 'label'))
        elif p in R.local:
            lines.append((p, 0, '%s:' % R.local[p][1] if R.local[p][0] == owner else '%s%s:' % R.local[p], 'label'))
        if kind == 'dd':
            lines.append((p, 4, 'dd %s' % sym(v, R, owner), 'dd')); continue
        if kind == 'db':
            lines.append((p, 1, 'db %s' % hexs(v), 'db')); continue
        var = variants.get(p, 0)
        if var == 99:
            bs = G1(p, n)
            txt = fmt_ins(R, p, v, owner, 0)
            fx = [q for q in range(p, p + n) if fix1.get(q)]
            if fx:     # bytes, with the fixup field as a dd of its symbol
                parts = []; q = p
                for f in fx:
                    if f > q: parts.append('db ' + ','.join(hexs(b) for b in G1(q, f - q)))
                    T = Gn.OBASE[fix1[f][0]] + fix1[f][1]
                    parts.append('dd ' + sym(T, R, owner)); q = f + 4
                if q < p + n: parts.append('db ' + ','.join(hexs(b) for b in G1(q, p + n - q)))
                lines.append((p, n, '\n        '.join(parts) + '\t; insn: ' + txt, 'raw')); continue
            lines.append((p, n, 'db ' + ','.join(hexs(b) for b in bs) + '\t; insn: ' + txt, 'raw')); continue
        lines.append((p, n, fmt_ins(R, p, v, owner, var), 'ins'))
    return lines

def assemble(R, lines, path):
    ext = set()
    defined = set()
    for p, n, t, k in lines:
        if k == 'label' and not t.startswith('.'): defined.add(t[:-1].split('.')[0] if t.count('.') else t[:-1])
    body = []
    for p, n, t, k in lines:
        if t is None: t = 'db ' + ','.join('0' for _ in range(n))
        body.append(t if k == 'label' else '        ' + t)
        if k != 'label':
            for w in re.findall(r'[A-Za-z_][\w.$?@]*', t.split(';')[0]):
                b = w
                if '.' in w and not w.startswith('.') and w.split('.')[0] in defined: continue
                if b and b not in defined and b not in REGS and not b.startswith('.') and b not in KEYWORDS: ext.add(b)
    src = 'bits 32\n%include "hockey.inc"\nsection t progbits alloc exec nowrite align=1\n'
    if ext: src += 'extern ' + ', '.join(sorted(ext)) + '\n'
    src += '\n'.join(body) + '\n'
    open(path + '.asm', 'w').write(src)
    r = subprocess.run(['nasm', '-O0', '-f', 'elf32', '-I', _os.path.join(REPO, 'src/inc/'), '-o', path + '.o', path + '.asm'], capture_output=True, text=True)
    if r.returncode: return None, r.stderr
    import link_src as L
    d, secs, sy, rels = L.read_elf(path + '.o')
    si = [i for i, s in enumerate(secs) if s['name'] == 't'][0]
    data = d[secs[si]['off']:secs[si]['off'] + secs[si]['size']]
    relpos = set()
    for o, symi, typ in rels.get(si, []):
        relpos.update(range(o, o + (1 if typ == 23 else 4)))
    return (data, relpos), None

REGS = set('eax ebx ecx edx esi edi ebp esp ax bx cx dx si di bp sp al bl cl dl ah bh ch dh cs ds es fs gs ss st0 st1 st2 st3 st4 st5 st6 st7 st cr0 cr2 cr3 dr0 dr7'.split())
KEYWORDS = set('byte word dword qword tword short near far nosplit LD rep repe repne repz repnz lock strict to'.split()) | set('st0 st1 st2 st3 st4 st5 st6 st7'.split())

def verify(R, lines, res):
    data, relpos = res
    bad = []
    for p, n, t, k in lines:
        if not n: continue
        off = p - R.a
        want = G1(p, n); got = data[off:off + n]
        fx = set()
        for q in range(p, p + n):
            if fix1.get(q): fx.update(range(q - R.a, q - R.a + 4))
        ok = len(got) == n and all(want[i] == got[i] or (off + i) in relpos or (off + i) in fx for i in range(n))
        if not ok: bad.append(p)
    if len(data) != R.b - R.a: bad.append(-1)
    return bad

def run(R, tmp):
    variants = {}
    order = [0, 1, 2, 3, 4, 5, 99]
    for rnd in range(40):
        lines = build_lines(R, variants)
        res, err = assemble(R, lines, tmp)
        if res is None:
            # find the erroring lines and move them to the next variant
            errl = [int(m) for m in re.findall(r'\.asm:(\d+):', err)]
            src = open(tmp + '.asm').read().split('\n')
            hdr = 4 if 'extern' in src[3] else 3
            body_idx = [i for i, l in enumerate(lines)]
            moved = 0
            for el in errl:
                li = el - 1 - hdr
                if 0 <= li < len(lines) and lines[li][3] in ('ins',):
                    p = lines[li][0]; cur = variants.get(p, 0)
                    variants[p] = order[order.index(cur) + 1] if cur in order and order.index(cur) + 1 < len(order) else 99; moved += 1
            if not moved: return lines, ['asm error: ' + err[:500]]
            continue
        bad = verify(R, lines, res)
        if not bad: return lines, []
        first_bad = [b for b in bad if b >= 0]
        # only the first few failing lines can be trusted (later ones may be shifted)
        changed = 0
        for p in first_bad[:1] if -1 in bad and False else first_bad:
            cur = variants.get(p, 0)
            if cur == 99: continue
            nxt = order[order.index(cur) + 1] if cur in order else 99
            variants[p] = nxt; changed += 1
        if not changed: return lines, ['unfixable at ' + ' '.join('%X' % b for b in bad[:10])]
    lines = build_lines(R, variants)
    res, err = assemble(R, lines, tmp)
    return lines, ([] if res and not verify(R, lines, res) else ['still bad'])

if __name__ == '__main__':
    regs = [Region(r) for r in regions]
    for R in regs: ALLREG[R.a] = R
    for R in regs: R.decode()
    allt = set()
    for R in regs:
        if not R.data: allt |= R.targets
    # a target another region refers to becomes a global label (<Routine>_<offset>), like the 1.0 cross-routine labels
    segs_ = Gn.I['segs']
    def file_of(r):
        a0 = r['a0']
        c = [x for x in segs_ if (x['start'] < a0 <= x['end'])] if r['a0'] == r['b0'] else [x for x in segs_ if x['start'] <= a0 < x['end']]
        return c[0]['src']
    for R in regs: R.file = file_of(R.r)
    for R in regs:
        if R.data: continue
        for S in regs:
            if S is R or S.data or S.file == R.file: continue
            for t in S.targets:
                if R.a <= t < R.b and t not in R.globals and t != R.a:
                    gl = sorted(x for x in R.globals if x < t)
                    base = gl[-1]; bn = R.globals[base].split('_')[0] if False else R.globals[base]
                    R.globals[t] = '%s_%X' % (bn, t - base)
    for R in regs:
        if not R.data: R.assign(allt)
    os.makedirs('regs', exist_ok=True)
    out = {}
    for R in regs:
        if R.a >= 0x160000: continue
        lines, errs = run(R, 'regs/r_%X' % R.a)
        nraw = sum(1 for l in lines if l[3] == 'raw')
        print('%X-%X lines %d raw %d %s' % (R.a, R.b, len(lines), nraw, '; '.join(errs)[:300]))
        out[R.a] = dict(a0=R.r['a0'], b0=R.r['b0'], a1=R.a, b1=R.b, lines=lines, errs=errs)
    import gen11 as G2
    segs = G2.I['segs']
    for R in regs:
        if not R.data: continue
        a0 = R.r['a0']
        seg = [s for s in segs if s['start'] <= max(a0 - 1, s['start']) < s['end'] and (s['start'] <= a0 < s['end'] or (a0 == s['end']))]
        seg = [s for s in segs if s['start'] < a0 <= s['end']] if R.r['a0'] == R.r['b0'] else [s for s in segs if s['start'] <= a0 < s['end']]
        seg = seg[0]
        bss = seg['bytes'] == 0
        lines = []
        labs = sorted(R.globals)
        p = R.a
        cuts = sorted(set([x for x in labs if R.a <= x < R.b] + [R.b]))
        for x in labs:
            pass
        pos = R.a
        for c in cuts:
            if pos < c:
                if bss:
                    lines.append((pos, c - pos, 'resb %d' % (c - pos), 'data'))
                else:
                    q = pos
                    while q < c:
                        if fix1.get(q):
                            T = Gn.OBASE[fix1[q][0]] + fix1[q][1]
                            lines.append((q, 4, 'dd ' + sym(T, R, None), 'data')); q += 4; continue
                        e = q
                        while e < c and e - q < 8 and not any(fix1.get(z) for z in range(e, e + 1)): e += 1
                        lines.append((q, e - q, 'db ' + ','.join(hexs(b) for b in G1(q, e - q)), 'data')); q = e
            if c < R.b:
                for al in Gn.aliases11.get(c, []): lines.append((c, 0, al + ':', 'label'))
                lines.append((c, 0, R.globals[c] + ':', 'label'))
            pos = c
        out[R.a] = dict(a0=R.r['a0'], b0=R.r['b0'], a1=R.a, b1=R.b, lines=lines, errs=[], data=True, bss=bss, file=seg['src'])
        print('data %X-%X %s %s labels %d' % (R.a, R.b, seg['src'], 'bss' if bss else '', len([l for l in lines if l[3] == 'label'])))
    pickle.dump(out, open('emitted.pkl', 'wb'))
