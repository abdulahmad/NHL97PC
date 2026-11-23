#!/bin/sh
# Regenerate the patch 1.1 code in src/ from the two retail executables.
#
#   tools/build/v11/run.sh HOCKEY10.EXE HOCKEY11.EXE
#
# Run it on a tree WITHOUT the 1.1 code (the commit before it went in): it builds 1.0, aligns the two
# executables, writes the 1.1 code of every changed routine and variable (each one assembled and checked
# byte for byte), puts it in src/ behind %if VERSION = 11 and writes src/segments_v11.txt.
# Then ./build.sh and ./build.sh 11 must both print MATCH. Needs python3 with iced-x86 and nasm.
# Names and comments of what only 1.1 has are in names11.py.
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
REPO=$(cd "$HERE/../../.." && pwd)
[ $# -eq 2 ] || { sed -n 2,4p "$0"; exit 1; }
WORK="$REPO/build/v11gen"
mkdir -p "$WORK"
cp "$1" "$WORK/hockey10.exe"; cp "$2" "$WORK/hockey11.exe"
cd "$REPO" && NHL97_EXE="$1" ./build.sh >/dev/null
cd "$WORK"
export PYTHONPATH="$HERE${PYTHONPATH:+:$PYTHONPATH}"
python3 "$HERE/align.py"       # 1.0 relocation fields and symbols from build/obj -> v10info.pkl
python3 "$HERE/align2.py"      # chunks between global labels, matched with fields masked -> align.pkl
python3 "$HERE/refine.py"      # resync inside chunks that moved
python3 "$HERE/refine2.py"
python3 "$HERE/votes.py"       # data deltas from the references in unchanged code
python3 "$HERE/check.py"       # every reference in unchanged code must land on its 1.1 target
python3 "$HERE/emit11.py"      # 1.1 code per changed region, verified -> emitted.pkl
sh "$HERE/renames10.sh"        # renames that apply to 1.0 too
python3 "$HERE/apply11.py"     # %if VERSION = 11 blocks, declarations, src/segments_v11.txt
