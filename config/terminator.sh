#!/bin/bash
# ⌬ ARCHON_SYSTEM | TERMINATOR LAYOUT ENGINE

BASE_DIR=$(dirname "$(readlink -f "$0")")/..
CONFIG_FILE="$BASE_DIR/config/terminator.conf"

if ! command -v terminator &> /dev/null; then
    echo "⌬ ERRO: Terminator não encontrado."
    exit 1
fi

echo "⌬ INVOCANDO QUAD-TERMINAL HIERARQUIA LEVEL 8..."

#!/bin/bash
# ⌬ ARCHON_SYSTEM | TERMINATOR ENGINE
# Forçamos o caminho real para teste definitivo

terminator --config=/home/harpia/archon-workstation/config/terminator.conf --layout=archon_level8 --maximize

