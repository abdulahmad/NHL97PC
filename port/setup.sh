#!/bin/sh
# Set up and build the SDL2 port on Debian / Ubuntu (also works in WSL2 with Ubuntu).
# Usage: port/setup.sh [/path/to/NHL97/game/files]
# The game's data files are not part of this repository; pass their directory to get a ready-to-run launcher.
set -e
cd "$(dirname "$0")/.."

if [ "$(uname -s)" != "Linux" ]; then
    echo "This port runs the game's 32-bit code natively, so it needs Linux (or WSL2)." >&2
    exit 1
fi

SUDO=""
[ "$(id -u)" -ne 0 ] && SUDO="sudo"

echo "== installing packages (needs sudo)"
$SUDO dpkg --add-architecture i386
$SUDO apt-get update
$SUDO apt-get install -y gcc-multilib g++-multilib libsdl2-dev:i386 pkg-config nasm make python3

echo "== building"
make sdl2

echo "== checking that the asm build still matches the retail EXE"
./build.sh 2>&1 | tail -1

if [ -n "$1" ]; then
    GAME=$(cd "$1" && pwd)
    cat > run-nhl97.sh <<EOF
#!/bin/sh
# Starts the game with its data files in $GAME
cd "$GAME" || exit 1
exec "$(pwd)/build/hockey97-linux" "\$@"
EOF
    chmod +x run-nhl97.sh
    echo "== start it with ./run-nhl97.sh"
else
    echo "== built build/hockey97-linux. Start it from the folder that holds the game data,"
    echo "   or run: NHL97_ROOT=/path/to/game/files build/hockey97-linux"
fi
