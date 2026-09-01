#!/data/data/com.termux/files/usr/bin/bash
#########################################################
# 🗑️ HACKLAB NEXUS - Zautomatyzowany Deinstalator v3.0.0
# Bezpiecznie wycofuje zmiany i czyści środowisko ARM
#
# Autor: @Anonymousik (Pull Request)
#########################################################

# ============== SYSTEM KOLORÓW =============
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

log_info() { echo -e "${CYAN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

show_banner() {
    clear
    echo -e "${RED}"
    cat << 'BANNER'
╔══════════════════════════════════════════════╗
║                                              ║
║  🗑️ HACKLAB NEXUS - SYSTEM WYCOFYWANIA 🗑️    ║
║                                              ║
╚══════════════════════════════════════════════╝
BANNER
    echo -e "${NC}"
}

confirm_uninstall() {
    log_warn "Ta operacja trwale usunie:"
    echo -e "  • Środowisko graficzne i narzędzia (v2.0 i v3.0.0)"
    echo -e "  • Pakiety OSINT (Kali/Parrot integracja)"
    echo -e "  • Pobraną paczkę APK z ~/Hacklab_APKs"
    echo -e "  • System zdalnej egzekucji"
    echo ""
    read -p "$(echo -e "${WHITE}Wpisz 'DELETE', aby zatwierdzić operację wycofywania: ${NC}")" confirm
    
    if [ "$confirm" != "DELETE" ]; then
        log_info "Anulowano proces odinstalowywania."
        exit 0
    fi
}

stop_processes() {
    log_info "Zabijanie aktywnych procesów i osieroconych wątków (Orphan processes)..."
    pkill -9 -f "termux.x11" 2>/dev/null
    pkill -9 -f "xfce" 2>/dev/null
    pkill -9 -f "pulseaudio" 2>/dev/null
    pkill -9 -f "wine" 2>/dev/null
}

remove_components() {
    log_info "Usuwanie niestandardowych skryptów (Remote Exec, Launchery)..."
    rm -f ~/start-nexus.sh ~/start-hacklab.sh ~/hacktools.sh ~/stop-hacklab.sh ~/remote-exec.sh
    rm -f ~/.config/hacklab-gpu.sh
    
    log_info "Usuwanie pobranych pakietów APK..."
    rm -rf ~/Hacklab_APKs 2>/dev/null
    
    log_info "Usuwanie warstwy Wine..."
    pkg uninstall hangover-wine hangover-wowbox64 -y 2>/dev/null
    
    log_info "Usuwanie modułów OSINT i narzędzi bezpieczeństwa..."
    pkg uninstall nmap sqlmap hydra john rust -y 2>/dev/null
    pip uninstall sherlock-project holehe requests beautifulsoup4 colorama -y 2>/dev/null
    
    log_info "Odinstalowywanie środowiska graficznego i akceleracji GPU..."
    pkg uninstall xfce4 xfce4-terminal termux-x11-nightly mesa-zink -y 2>/dev/null
    
    log_info "Czyszczenie pozostałości konfiguracji..."
    rm -rf ~/.config/xfce4 ~/.cache/xfce4 ~/.wine ~/Desktop 2>/dev/null
    pkg clean 2>/dev/null
}

main() {
    show_banner
    confirm_uninstall
    stop_processes
    remove_components
    
    echo ""
    log_success "Środowisko Hacklab Nexus v3.0.0 zostało pomyślnie i bezpiecznie usunięte."
}

main
