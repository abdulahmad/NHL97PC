# In-game player streaks: handoff (2026-11-16)

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
