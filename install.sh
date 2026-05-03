#!/bin/bash
# ⌬ ARCHON_SYSTEM | UNIVERSAL DEPENDENCY INSTALLER v2.0
# FOCO: KITTY RENDER ENGINE & ARCHONPLAYER FORGE

G='\033[38;5;46m'; Y='\033[38;5;226m'; VINHO='\033[38;5;88m'; NC='\033[0m'

echo -e "${G}⌬ ESCANEANDO DNA DO SISTEMA PARA DEPENDÊNCIAS...${NC}"

# 1. Ferramentas base (Kitty e w3m agora são obrigatórios)
DEPS=("terminator" "btop" "gum" "kitty" "w3m" "git" "gcc" "make")

# Detecta o Gerenciador de Pacotes
if command -v pacman >/dev/null; then
    PKG_MGR="sudo pacman -S --needed --noconfirm"
elif command -v apt-get >/dev/null; then
    PKG_MGR="sudo apt-get install -y"
elif command -v dnf >/dev/null; then
    PKG_MGR="sudo dnf install -y"
else
    echo -e "${VINHO}⌬ ERRO: Gerenciador de pacotes não suportado.${NC}"
    exit 1
fi

# 2. Instala ferramentas base do sistema
for tool in "${DEPS[@]}"; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo -e "${Y}⌬ Instalando $tool...${NC}"
        $PKG_MGR "$tool"
    else
        echo -e "${G}⌬ $tool já está presente.${NC}"
    fi
done

# 3. Forja do ARCHONPLAYER-TUI (Compilação com SDL2)
if ! command -v archonplayer &> /dev/null; then
    echo -e "${Y}⌬ ARCHONPLAYER não detectado. Iniciando forja do binário...${NC}"
    
    # Instala bibliotecas de áudio e interface para a compilação
    if command -v pacman >/dev/null; then
        sudo pacman -S --needed --noconfirm ncurses sdl2 sdl2_mixer
    elif command -v apt-get >/dev/null; then
        sudo apt-get install -y libncurses5-dev libncursesw5-dev libsdl2-dev libsdl2-mixer-dev build-essential
    fi

    # Clona e compila a partir do seu repositório oficial
    git clone https://github.com /tmp/archonplayer
    cd /tmp/archonplayer/archonplayer && make
    sudo make install
    cd - && rm -rf /tmp/archonplayer
else
    echo -e "${G}⌬ ARCHONPLAYER já integrado ao núcleo.${NC}"
fi

# 4. Sincronização de Permissões
echo -e "${G}⌬ SINCRONIZANDO PERMISSÕES DA WORKSTATION...${NC}"
chmod +x archon.sh
chmod +x core/engine.sh
chmod +x config/terminator.sh
chmod +x modules/workstation.sh

echo -e "${Y}⌬ SISTEMA PRONTO. RENDER ENGINE: KITTY [ATIVADO]${NC}"
echo -e "${G}⌬ EXECUTE ./archon.sh PARA INICIAR.${NC}"
