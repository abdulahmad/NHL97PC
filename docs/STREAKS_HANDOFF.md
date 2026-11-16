# In-game player streaks: handoff (2026-11-16)

## Resolved (2026-11-16)
The x87 register stack. The Watcom start-up (`__sys_init_387_emulator`, 121AD0) ends with four `fldz` and leaves the stack
"4 empty / 4 full". EA's model loader needs more than four registers, the stack overflowed while the players' 8-vertex chest and
shoulder model was read (tick 8476 in the trace, the tag word went 55FF -> F5FF -> FDFF), and a real FPU answers a masked overflow
with NaN: the model's vertex 3 was (0.06, NaN, NaN) for the whole game. `sub_FFBE0` (the players' float projection, called from
10B0D4) made it x = y = 80000000h, the polygon filler at 112540 clipped it at the left screen edge and drew rows from x = 0 with
`sub_12D784`. DOSBox's FPU does not fault on the overflow, so the dummy zeros are just overwritten there. Fix: `port/overrides.c`
nops the four `fldz` in the loaded image (`NHL97_X87DUMMIES=1` keeps them). Checked over 2.7 million projections: no bad vertex,
tag word FFFF, no streak in 297 rink screenshots. The crest theory below was close: the bad vertex is in the chest model.

How it was found: a write trap on the off-screen frame gave the writer of the streak rows (12D784 from 112546), a trap at 112540
gave the edge records (left edge x = 0 for 14 rows: a clipped polygon), a trap at 10B0EA gave the NaN vertex and the tag word.
The rest of this file is the state before that.

## Symptom
In-game (8-bit VESA 0x101, overhead camera), blocks of 5-12 screen rows at a player's position are
filled with one flat colour from x=0 to the player's x, changing every frame. Only players are hit,
never arena geometry; some players are fine at a given moment. Abdul: the streaks seem to come from
the chest/shoulder area; jersey numbers on the back draw fine, but he has never seen a properly drawn
team crest. Not a bank-boundary effect. DOSBox-X with the same game files shows no streaks.

## Ruled out
- VESA bank switching; wide or reversed spans at sub_10F2A0.
- x87 precision / control word; fxsave around the VEH; the 1/n table.
- rdtsc: emulated at 200/100/133 MHz (port/emu.c), and since 69f33b7 locked to the game's tickcount
  the way patch 1.1 uses the PIT (default; NHL97_TSC=host = old host-clock answer). Streaks remain.
- CPUID family/MMX variants. Low-memory reads (NHL97_LOWLOG: only BIOS data at 138F20 and C library).
- Patch 1.1: tools/re/diff_versions.py shows 100 of 3,376 routines changed, NONE in the renderer
  (SHPI 10E690-10FEE8, polygons 10FEE8-112B84, clipper sub_112F3C, span drawer sub_12D784 identical).
  1.1 changes faceoffs, engine 42AD0-4AA78, front end, network/modem E2E28-E4908, and adds a PIT
  fallback where rdtsc is used (sub_F9650 speed measure, 14CDD step stamp, sub_65164 interpolation).
- Data breakpoints do not fire on the laptop.
- Not yet concluded: NHL97_SOUND=none (does IRQ injection disturb the renderer?).

## Lead: the crest
Chest = team crest. Theory: one vertex of the crest/decal polygon gets a garbage (huge negative / NaN ->
0x80000000 from fistp) screen x, so the clipper fills from x=0. Check first:
1. Does a crest/uniform file fail to open? Run with NHL97_VLOG=1 (every DOS open logged; failures always
   print `dos: open "..." failed`). Candidates: 3DLOGOS.VIV (in the install file table at 169E36),
   uni%04d.viv (code at 5815B), PLYRCOMN.VIV / MASKS.VIV (57966/57A54), faces.viv (5B66D), %05d.fsh (58C35).
2. If files load, follow how the crest texture/vertices are built (uni*.viv loader near 5815B) and log the
   projected vertices of player polygons whose x goes below 0 or is 0x80000000.

## Running a test on the laptop (via Remote Control)
- Branch claude/project-thread-vmz6nz; build `make sdl2-win` (or port/build-win.sh, SDL2_MINGW=/c/msys64/ucrt64).
- Copy the exe into C:\Repository\_wt97 under a test name (never Abdul's game folder); NHL97_CD=C:\Repository\_wt97\cd.
- NHL97_KEYS="3000:Escape" skips the intro movie. The attract game starts ~130 s without menus (no keys needed).
  If a game is started from the menus with Play-by-Play on, a "Play-by-Play needs to be installed" prompt
  appears while loading: the cursor starts on X (No); send Enter. Don't leave it sitting there.
- NHL97_DUMP=<dir> for screenshots. No simulated desktop input, never close Abdul's games, no cmd /c.
