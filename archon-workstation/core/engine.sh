#!/bin/bash
# ⌬ ARCHON_SYSTEM | CORE ENGINE v1.0
# Local: /home/harpia/archon-workstation/core/engine.sh

# --- DETECÇÃO DE DEPENDÊNCIAS ---
# Verifica se as ferramentas essenciais estão no DNA do sistema
check_environment() {
    local tools=("terminator" "btop" "gum" "kitty")
    local missing=()

    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing+=("$tool")
        fi
    done

    if [ ${#missing[@]} -ne 0 ]; then
        echo -e "\e[38;5;88m⌬ ALERTA: Dependências ausentes: ${missing[*]}\e[0m"
        echo -e "\e[38;5;46m⌬ Sugestão: Instale-as para garantir a performance total.\e[0m"
        # Não trava o sistema, apenas avisa (Mentalidade Universal)
    fi
}

# --- FUNÇÃO DE LOG ---
log_status() {
    local msg=$1
    echo -e "\e[38;5;226m[⌬ ARCHON_ENGINE]:\e[0m $msg"
}

# Executa a checagem ao carregar
check_environment
