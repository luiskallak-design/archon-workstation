#!/bin/bash
# [ HELLANOS ACADEMY - LEVEL 8 : UNIVERSAL WORKSTATION ]
# MODO: AUTO-ADAPTATIVO (ESCANEAMENTO DE DNA DO SISTEMA)

# --- PALETA DE CORES TÁTICAS ---
G='\033[38;5;46m'; Y='\033[38;5;226m'; VINHO='\033[38;5;88m'; NC='\033[0m'

# --- BANCO DE DADOS DE ENTIDADES UNIVERSAIS ---
CATEGORIAS=(
    "ARCHON|archonplayer|⚡|FLUXO DE ÁUDIO"
    "ÍCARO|chromium,firefox,google-chrome-stable,links,lynx|🕊️|Navegação Auxiliar"
    "PROMETEU|geany,micro,vim,nano,code,emacs|🔥|Forja de Código"
    "APOLO|vlc,mplayer,ytfzf,mpv|☀️|Espectro de Mídia"
    "PSIQUÊ|gimp,inkscape,krita|🦋|Manifestação Visual"
    "HERMES|qbittorrent,transmission-gtk,aria2c|📦|Tráfego de Dados"
    "PAN|pcmanfm,nnn,ranger,thunar|📂|Arquivos e Estruturas"
    "CRONOS|btop,htop,fastfetch,neofetch|⏳|Monitoramento de Ciclos"
    "HEFESTO|flameshot,lxappearance,nitrogen|🛠️|Ajuste de Interface"
)

# Verifica quais apps de uma lista estão realmente instalados no PATH
check_installed() {
    local bins_str=$1
    local installed=()
    IFS=',' read -ra ADDR <<< "$bins_str"
    for bin in "${ADDR[@]}"; do
        if command -v "$bin" >/dev/null 2>&1; then
            installed+=("$bin")
        fi
    done
    echo "${installed[@]}"
}

smart_launch() {
    local cmd=$1
    # Lista de apps que precisam de terminal (TUIs)
    local tui_apps="archonplayer micro vim nano btop nnn ytfzf fastfetch ranger htop links lynx"
    local base_cmd=$(basename "$cmd")
    
    if [[ " $tui_apps " =~ " $base_cmd " ]]; then
        # Se for TUI, tenta abrir no Kitty (ou terminal padrão se não houver Kitty)
        if command -v kitty >/dev/null 2>&1; then
            nohup kitty -e bash -c "$cmd" >/dev/null 2>&1 &
        else
            nohup x-terminal-emulator -e "$cmd" >/dev/null 2>&1 &
        fi
    else
        nohup "$cmd" >/dev/null 2>&1 &
    fi
}

show_banner() {
    clear
    gum style \
        --foreground 88 --border-foreground 46 --border double \
        --align center --width 60 --margin "1 1" --padding "1 1" \
        "⌬ HELLANOS ACADEMY ⌬" "WORKSTATION UNIVERSAL v8"
}

workstation_menu() {
    # O GUM é a única dependência obrigatória para o menu
    if ! command -v gum >/dev/null 2>&1; then
        echo -e "${VINHO}⌬ ERRO: 'gum' não encontrado. Instale-o para rodar a workstation.${NC}"
        exit 1
    fi

    while true; do
        show_banner
        MENU_OPTS=()
        VALID_CATS=()

        # SCANNER: Monta o menu dinamicamente
        for cat in "${CATEGORIAS[@]}"; do
            IFS="|" read -r nome bins icone desc <<< "$cat"
            APPS_OK=$(check_installed "$bins")
            
            if [ ! -z "$APPS_OK" ]; then
                MENU_OPTS+=("$icone  $nome  ───  $desc")
                VALID_CATS+=("$cat")
            fi
        done
        
        MENU_OPTS+=("    RETORNAR AO NADA")

        ESCOLHA=$(gum choose "${MENU_OPTS[@]}" \
            --header="DNA Escaneado. Invoque uma entidade disponível:" \
            --cursor.foreground="46" --selected.foreground="226" --height=15)

        [[ -z "$ESCOLHA" || "$ESCOLHA" == *"RETORNAR"* ]] && exit 0

        for cat in "${VALID_CATS[@]}"; do
            IFS="|" read -r n bins icone desc <<< "$cat"
            if [[ "$ESCOLHA" == *"$n"* ]]; then
                APPS_DISPONIVEIS=($(check_installed "$bins"))
                
                if [ "${#APPS_DISPONIVEIS[@]}" -gt 1 ]; then
                    SUB_ESCOLHA=$(gum choose "${APPS_DISPONIVEIS[@]}" \
                        --header="Múltiplas formas de $n detectadas:" --cursor.foreground="88")
                    [ ! -z "$SUB_ESCOLHA" ] && smart_launch "$SUB_ESCOLHA"
                else
                    smart_launch "${APPS_DISPONIVEIS[0]}"
                fi
            fi
        done
        sleep 0.2
    done
}

workstation_menu
