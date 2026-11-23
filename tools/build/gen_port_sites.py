#!/usr/bin/env python3
"""gen_port_sites.py - write port/flagops.h: the instructions the SDL2 port traps, for 1.0 and for patch 1.1.

  python3 tools/build/gen_port_sites.py [--check]

The port (port/emu.c) replaces every pushf / popf of the game with int3 and emulates it, and answers every rdtsc
itself. This tool finds those instructions in src/ from a NASM listing of each file, once with -dVERSION=10 and
once with -dVERSION=11, and places each file at its start in src/segments.txt or src/segments_v11.txt. A
`db ...  ; insn: popf` line counts as the instruction in its comment. The result is checked against the bytes of
build/parts (1.0) and build/v11/parts (1.1) when they are there (after ./build.sh and ./build.sh 11).
--check: write nothing; exit 1 if port/flagops.h is not what would be written."""
import json, os, re, subprocess, sys, tempfile
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, 'src')
NASM = os.environ.get('NASM', 'nasm')
OUT = os.path.join(ROOT, 'port', 'flagops.h')
LST = re.compile(r'^\s*(\d+) ([0-9A-F]{8}) ([0-9A-F]+)\S*\s+(.*)$')
FLAG = {'pushf': 0, 'pushfd': 0, 'popf': 1, 'popfd': 1, 'pushfw': 2, 'popfw': 3}
# _DoINTR_'s pushf (lib/dos4gw/dos4gw_int386x.asm) was never trapped (the IDA listing the first table came from
# missed it) and the port runs fine without it; it stays untrapped so 1.0 behaves exactly as before.
SKIP = {'lib/dos4gw/dos4gw_int386x.asm'}
BYTES = {0: b'\x9c', 1: b'\x9d', 2: b'\x66\x9c', 3: b'\x66\x9d', 'rdtsc': b'\x0f\x31'}


def layout(ver):
    name = 'segments.txt' if ver == 10 else 'segments_v11.txt'
    out = []
    for ln in open(os.path.join(SRC, name)):
        p = ln.split()
        if ln.startswith('#') or len(p) < 6: continue
        out.append((int(p[1], 16), p[5]))
    return out


def sites(ver):
    flags, tsc = [], []
    with tempfile.TemporaryDirectory() as td:
        for start, src in layout(ver):
            if src in SKIP: continue
            path = os.path.join(SRC, src)
            text = open(path, encoding='latin1').read()
            if not re.search(r'\b(pushf|popf|rdtsc)|insn:\s*(pushf|popf|rdtsc)', text): continue
            lst = os.path.join(td, 'f.lst')
            r = subprocess.run([NASM, '-O0', '-f', 'elf32', '-dVERSION=%d' % ver, '-I', os.path.join(SRC, 'inc') + '/',
                                '-l', lst, '-o', os.devnull, path], capture_output=True, text=True)
            if r.returncode: sys.exit('nasm failed on %s:\n%s' % (src, r.stderr))
            for ln in open(lst, encoding='latin1'):
                m = LST.match(ln)
                if not m: continue
                s = m.group(4)
                x = re.search(r';\s*insn:\s*(\w+)', s)
                code = (x.group(1) if x and s.lstrip().startswith('db') else s.split(';')[0]).strip().lower()
                op = code.split()[0] if code else ''
                a = start + int(m.group(2), 16)
                if op in FLAG: flags.append((a, FLAG[op]))
                elif op == 'rdtsc': tsc.append(a)
    return sorted(flags), sorted(tsc)


def image(ver):
    parts = os.path.join(ROOT, 'build', 'parts' if ver == 10 else 'v11/parts')
    try: man = json.load(open(os.path.join(parts, 'manifest.json')))
    except OSError: return None
    return b''.join(open(os.path.join(parts, s['file']), 'rb').read() for s in man['segments'] if s['obj'] == 1 and s['file'])


def table(name, rows, per=4):
    out = ['static const flagop_t %s[] = {' % name]
    for i in range(0, len(rows), per): out.append('    ' + ', '.join(rows[i:i + per]) + ',')
    return out + ['};']


def render():
    out = ['/* The instructions the port traps in object 1 of HOCKEY.EXE, for retail 1.0 and patch 1.1',
           ' * (tools/build/gen_port_sites.py, from NASM listings of src/; do not edit).',
           ' * flagops: pushf / popf, kind 0 pushf, 1 popf, 2 pushfw, 3 popfw. rdtsc: each rdtsc. */']
    for ver in (10, 11):
        flags, tsc = sites(ver)
        img = image(ver)
        if img is not None:
            for a, k in flags + [(a, 'rdtsc') for a in tsc]:
                b = BYTES[k]
                if img[a - 0x10000:a - 0x10000 + len(b)] != b: sys.exit('%d: %X is not %s' % (ver, a, b.hex()))
        out += table('flagops%d' % ver, ['{ 0x%X, %d }' % f for f in flags])
        out += ['static const uint32_t rdtsc_sites%d[] = { %s };' % (ver, ', '.join('0x%X' % a for a in tsc))]
    return '\n'.join(out) + '\n'


def main():
    new = render()
    old = open(OUT).read() if os.path.exists(OUT) else ''
    if '--check' in sys.argv:
        print('flagops.h up to date' if new == old else 'flagops.h is stale: run tools/build/gen_port_sites.py')
        sys.exit(0 if new == old else 1)
    open(OUT, 'w').write(new)
    print('wrote port/flagops.h')


if __name__ == '__main__':
    main()
