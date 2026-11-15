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
- Not wired yet (96 addresses that 97 has elsewhere): online play (`port/netplay_off.c` stands in), the automatic on-screen
  keyboard (F9 still opens it), the sound start-up log, the TGV palette sync, the default `GLOBAL.SET`.

## Test aids

As in 96, with `NHL97_` names: `NHL97_KEYS="ms:Key ..."` (scripted keys, no window focus needed), `NHL97_TRACE=1`,
`NHL97_STATS=1`, `NHL97_SOUND=none`, `NHL97_AUDIOLOG=1`, and Overbar's `OVERBAR_TEST_KEYS` / `OVERBAR_TEST_LOG` / `OVERBAR_TEST_DUMP`.
