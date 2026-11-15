#!/bin/sh
# One-command build: HOCKEY.EXE from src/ + sha1 check.  Usage: ./build.sh [path/to/HOCKEY.EXE]
# Steps: extract the third-party stubs and LE metadata from your EXE, nasm every src/ file, link, sha1 check.
# The last line is MATCH or MISMATCH. See docs/ASM_BUILD.md.
set -e
cd "$(dirname "$0")"
PY="${PYTHON:-python3}"
NASM="${NASM:-nasm}"
EXE="${1:-${NHL97_EXE:-}}"
[ -n "$EXE" ] || for p in retail/HOCKEY.EXE HOCKEY.EXE ../EA-NHL-Disassembly-Project/NHL97-PC/HOCKEY.EXE; do [ -f "$p" ] && { EXE="$p"; break; }; done
[ -f "$EXE" ] || { echo "HOCKEY.EXE not found: put NHL 97 HOCKEY.EXE (1865388 bytes, SHA-1 b5cba11fd78b3db4c9085ca11918128e52b76bdd) in retail/ or set NHL97_EXE or pass a path" >&2; exit 1; }
command -v "$NASM" >/dev/null || { echo "nasm not found (apt install nasm / brew install nasm; or set NASM=)" >&2; exit 1; }
"$PY" tools/build/rebuild_exe.py extract "$EXE" build/parts
JOBS="$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 4)"
SRCS="$(awk '!/^#/ && NF {print "src/" $6}' src/segments.txt)"
echo "assembling $(echo "$SRCS" | wc -l) files with $JOBS jobs"
echo "$SRCS" | xargs -P "$JOBS" -I{} sh -c '
  o="build/obj/${1#src/}"; o="${o%.asm}.o"; mkdir -p "$(dirname "$o")"
  if [ ! -f "$o" ] || [ "$1" -nt "$o" ] || [ -n "$(find src/inc -newer "$o" -print -quit)" ]; then '"$NASM"' -O0 -f elf32 -I src/inc/ -o "$o" "$1"; fi' _ {}
"$PY" tools/build/link_src.py --obj build/obj --parts build/parts --out build/HOCKEY.EXE
