#!/bin/bash
# ⌬ ARCHON_SYSTEM | STANDALONE WORKSTATION LOADER
# MODO: UNIVERSAL (AUTO-DETECÇÃO DE DIRETÓRIO)

# 1. Identifica o diretório onde o script está localizado
# Isso substitui o "/opt/archia" fixo e funciona em qualquer distro.
BASE_DIR=$(dirname "$(readlink -f "$0")")

# 2. Entra na pasta do projeto para garantir que as chamadas relativas funcionem
cd "$BASE_DIR"

# 3. Carrega as bibliotecas usando caminhos dinâmicos
# O script agora procura as pastas lib, security e modules dentro de onde ele foi baixado.
if [[ -f "./lib/ui.sh" ]]; then source "./lib/ui.sh"; fi
if [[ -f "./security/mode.sh" ]]; then source "./security/mode.sh"; fi

# O workstation.sh contém a lógica do menu inteligente que criamos
if [[ -f "./modules/workstation.sh" ]]; then 
    source "./modules/workstation.sh"
else
    echo -e "\033[38;5;88m⌬ ERRO: Módulo 'workstation.sh' não encontrado em $BASE_DIR/modules/\033[0m"
    exit 1
fi

# Cores de sinalização (Backup caso o ui.sh não carregue)
VINHO='\033[38;5;88m'; G='\033[38;5;46m'; NC='\033[0m'

# Mensagem de Log tático
echo -e "${G}⌬ INICIALIZANDO MATRIZ STANDALONE EM: ${NC}$BASE_DIR"
sleep 0.5

# 4. Executa a função principal do menu
workstation_menu
