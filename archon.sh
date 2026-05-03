#!/bin/bash
# ⌬ ARCHON_SYSTEM | MAIN LAUNCHER
# Local: /home/harpia/archon-workstation/archon.sh

# 1. Pega o caminho de onde o script está (Universal)
BASE_DIR=$(dirname "$(readlink -f "$0")")

# 2. Carrega o DNA do sistema (Engine)
if [[ -f "$BASE_DIR/core/engine.sh" ]]; then
    source "$BASE_DIR/core/engine.sh"
fi

# 3. Carrega o menu inteligente que está na pasta modules
if [[ -f "$BASE_DIR/modules/workstation.sh" ]]; then
    source "$BASE_DIR/modules/workstation.sh"
else
    echo "⌬ ERRO: modules/workstation.sh não encontrado!"
    exit 1
fi

# 4. Inicia a workstation
workstation_menu
