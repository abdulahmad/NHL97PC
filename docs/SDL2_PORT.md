# SDL2 port (`port/`, on Overbar)

The game's own 32-bit code runs natively through SDL2 on Windows and Linux, the same way as
[NHL96PC](https://github.com/abdulahmad/NHL96PC)'s port, whose host this is. `src/` is not touched: `./build.sh` still prints MATCH.

`port/le_load.c` loads your retail `HOCKEY.EXE` (next to the program, in `retail/`, or `NHL97_EXE`), maps the four LE objects at
`0x20000000` and applies the fixups. Watcom `start` is skipped: the host fills the C library's start-up variables and calls
`__InitRtns` / `__CMain`. DOS, DPMI, the VESA BIOS, the mouse driver, the timer, keyboard, sound cards and joystick are emulated in
`port/` (the instruction that needs them faults and the host answers it). The window, menu bar, overlay, scaler and controllers are
[Overbar](https://github.com/abdulahmad/overbar), the git submodule `port/overbar` (`git submodule update --init`).

## Build

```
make sdl2-win      # port/build-win.sh -> build/win/hockey97-win32.exe + SDL2.dll (mingw-w64; port/setup-win.sh installs it)
make sdl2          # port/build.sh -> build/hockey97-linux (gcc-multilib, libsdl2-dev:i386)
```

Run it in the folder with the installed NHL 97 game files, or set `NHL97_ROOT`. Settings are kept in `hockey97-win32.ini`
(`hockey97-linux.ini`) next to the program.

## What is 97's own

The game addresses the host uses are `SYM_<label>` names of this source tree (`port/game_syms.h`, written by
`tools/build/gen_port_syms.py`). `port/flagops.h` (every pushf / popf, trapped so the interrupt flag is virtual) is written by
`tools/build/gen_flagops.py` from the IDA listing. Differences from the 96 host:

- No bound DOS/4GW in the EXE: the LE header is at 2C90h.
- `WaitRetrace` has no mode switch; its loop count is `dword_171E34`. `WaitDisplayRetrace` had no label in the listing.
- `WaitTicks` runs the game's task list (`sub_F9A88`) while it waits, so it is not replaced; `TickDeadlinePassed` uses edx.
- NHL 97 asks for 640x480 with 16-bit colour (VESA 0111h, 5:6:5) first: the front end and the TGQ movies are drawn in it, the
  game itself in 0101h (8 bits). `NHL97_NOHICOLOR=1` hides 0111h (the movies and menus are then black).
- The front end loads partial palettes without waiting for the retrace: a palette the game has stopped writing is shown.
- `WaitRetrace` and friends start with `66 BA` (mov dx, 3DAh) and are replaced like 96's.
- The movies are TGQ (true colour), not 96's TGV, so there is no TGV palette sync to do.
- The x87 register stack starts empty: the four `fldz` at the end of the Watcom start-up (121AF3, "4 empty / 4 full") are nops in
  the loaded image. With them EA's model loader overflowed the stack, a real FPU answered with NaN, and the players' chest model
  kept a NaN vertex: rows of jersey colour from the left edge of the screen to each player. DOSBox ignores the overflow.
  `NHL97_X87DUMMIES=1` keeps the four `fldz` (`port/overrides.c`).
- The on-screen keyboard opens by itself in `EditText` (7FEC4), the routine every name entry goes through.
- Not wired yet: the sound start-up log.
- GLOBAL.SET: when neither the game folder nor `$NHL97_CD` has one, the port writes a real SETUP-written 97 file (magic 16059h, install
  mode 3, CD at D:\); `NHL97_NO_DEFAULT_SET=1` turns that off.

Escape skips the intro movie (`NHL97_KEYS="20000:Escape"` in tests). `NHL97_VLOG=1` logs, once a second, the video hardware use,
the tick count and every file open.

## Online play

The same rollback design as the 96 port (`port/netplay.c`; Overbar's `overbar/net.h`, `overbar/rollback.h`, `overbar/netgame.h`):

- each pass of GameLoop is one step: InputRecordAvail asks netplay.c, which pushes a record (14h bytes: the 8 SlotWords, the
  HotKeyFlags without the pause bit, 3 ticks) made of both machines' slot word and flags (two Overbar pads a machine); the record
  timer InputRecordTimer does nothing;
- tickcount counts 3 a step from the first step (TimerISR's `inc dword [tickcount]` is redirected);
- the players are not drawn between steps online (the rdtsc at 14CDD reads InputRecordStamp), as the game does in its own network play;
- the host's options (the 130h block), set-up (teams, user logs, the 8 controller bytes) and both seeds go to the guest; slot 0 is
  the host's team, slot 1 the other; RunInGameMenu is skipped online;
- a state is the game's image and DOS / DPMI memory without the key table, SlotWords and hot keys, plus the game thread's stack.

Test aid (two copies on one machine): `NHL97_ONLINE=host` / `join` (port `NHL97_PORT`, default 41970), `NHL97_NETSIM=delay,jitter,loss%`,
`NHL97_AUTOPAD=1`, `NHL97_REGIONS=1`, `NHL97_SOUND=none` (the sound cards are not in the states yet).
