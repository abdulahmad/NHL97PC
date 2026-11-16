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
- The on-screen keyboard opens by itself in `EditText` (7FEC4), the routine every name entry goes through.
- Not wired yet (96 addresses that 97 has elsewhere): online play (`port/netplay_off.c` stands in; 97's game loop is new, none of
  96's hook points matched), the sound start-up log, the default `GLOBAL.SET`.

Escape skips the intro movie (`NHL97_KEYS="20000:Escape"` in tests). `NHL97_VLOG=1` logs, once a second, the video hardware use,
the tick count and every file open.
