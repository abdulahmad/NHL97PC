#!/bin/sh
# One-command build: HOCKEY.EXE from src/ + sha1 check.  Usage: ./build.sh [11] [path/to/HOCKEY.EXE]
#   ./build.sh       NHL 97 1.0 (the retail CD): build/HOCKEY.EXE
#   ./build.sh 11    patch 1.1: the same source with VERSION=11, laid out by src/segments_v11.txt: build/v11/HOCKEY.EXE
# Steps: extract the third-party stubs and LE metadata from your EXE, nasm every src/ file, link, sha1 check.
# The last line is MATCH or MISMATCH. See docs/ASM_BUILD.md.
set -e
cd "$(dirname "$0")"
PY="${PYTHON:-python3}"
NASM="${NASM:-nasm}"
VER=10
case "$1" in 10|11) VER="$1"; shift;; esac
export NHL97_VERSION="$VER"
if [ "$VER" = 11 ]; then
  EXE="${1:-${NHL97_EXE11:-}}"
  [ -n "$EXE" ] || for p in retail/HOCKEY11.EXE ../EA-NHL-Disassembly-Project/NHL97-PC/1.1/HOCKEY.EXE; do [ -f "$p" ] && { EXE="$p"; break; }; done
  [ -f "$EXE" ] || { echo "patch 1.1 HOCKEY.EXE not found: put it (1871324 bytes, SHA-1 dadba8ec9aeb111f044ca2457736447ef2929809) at retail/HOCKEY11.EXE or set NHL97_EXE11 or pass a path" >&2; exit 1; }
  OBJ=build/v11/obj PARTS=build/v11/parts WORK=build/v11/link OUT=build/v11/HOCKEY.EXE
else
  EXE="${1:-${NHL97_EXE:-}}"
  [ -n "$EXE" ] || for p in retail/HOCKEY.EXE HOCKEY.EXE ../EA-NHL-Disassembly-Project/NHL97-PC/HOCKEY.EXE; do [ -f "$p" ] && { EXE="$p"; break; }; done
  [ -f "$EXE" ] || { echo "HOCKEY.EXE not found: put NHL 97 HOCKEY.EXE (1865388 bytes, SHA-1 b5cba11fd78b3db4c9085ca11918128e52b76bdd) in retail/ or set NHL97_EXE or pass a path" >&2; exit 1; }
  OBJ=build/obj PARTS=build/parts WORK=build/link OUT=build/HOCKEY.EXE
fi
command -v "$NASM" >/dev/null || { echo "nasm not found (apt install nasm / brew install nasm; or set NASM=)" >&2; exit 1; }
"$PY" tools/build/rebuild_exe.py extract "$EXE" "$PARTS"
JOBS="$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 4)"
SRCS="$(awk '!/^#/ && NF {print "src/" $6}' src/segments.txt)"
echo "assembling $(echo "$SRCS" | wc -l) files with $JOBS jobs (version $VER)"
echo "$SRCS" | OBJ="$OBJ" VER="$VER" NASM="$NASM" xargs -P "$JOBS" -I{} sh -c '
  o="$OBJ/${1#src/}"; o="${o%.asm}.o"; mkdir -p "$(dirname "$o")"
  if [ ! -f "$o" ] || [ "$1" -nt "$o" ] || [ -n "$(find src/inc -newer "$o" -print -quit)" ]; then $NASM -O0 -f elf32 -dVERSION=$VER -I src/inc/ -o "$o" "$1"; fi' _ {}
"$PY" tools/build/link_src.py --obj "$OBJ" --parts "$PARTS" --work "$WORK" --out "$OUT"
