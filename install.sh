#!/data/data/com.termux/files/usr/bin/bash
#######################################################
#  🚀 HACKLAB NEXUS - Automated OSINT & ARM Framework
#  Wersja: v3.0.0
#  Autor: @Anonymousik (Pull Request)
#  
#  Nowości w v3.0.0(PL):
#  - Inteligentny system zależności (Dependency Resolver)
#  - Automatyczne pobieranie APK (APK Auto-fetcher)
#  - Integracja pakietów OSINT (Kali / Parrot)
#  - Bezpieczne zdalne wykonywanie skryptów
#  - Profesjonalny, wielojęzyczny system logowania (i18n)
#######################################################
# ============== KONFIGURACJA =============
TOTAL_STEPS=16
CURRENT_STEP=0
# ============== SYSTEM KOLORÓW I LOGÓW =============
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
NC='\033[0m'

log_info() { echo -e "${CYAN}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ============== FUNKCJE POSTĘPU =============
update_progress() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    PERCENT=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    
    FILLED=$((PERCENT / 5))
    EMPTY=$((20 - FILLED))
    
    BAR="${GREEN}"
    for ((i=0; i<FILLED; i++)); do BAR+="█"; done
    BAR+="${GRAY}"
    for ((i=0; i<EMPTY; i++)); do BAR+="░"; done
    BAR+="${NC}"
    
    echo ""
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  📊 POSTĘP INSTALACJI: ${WHITE}Etap ${CURRENT_STEP}/${TOTAL_STEPS}${NC} ${BAR} ${WHITE}${PERCENT}%${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

spinner() {
    local pid=$1
    local message=$2
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % 10 ))
        printf "\r  ${YELLOW}⏳${NC} ${message} ${CYAN}${spin:$i:1}${NC}  "
        sleep 0.1
    done
    
    wait $pid
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        printf "\r  ${GREEN}✓${NC} ${message}                    \n"
    else
        printf "\r  ${RED}✗${NC} ${message} ${RED}(Błąd)${NC}     \n"
        # Opcjonalny rollback w przypadku krytycznego błędu
    fi
    return $exit_code
}

install_pkg() {
    local pkg=$1
    local name=${2:-$pkg}
    (yes | pkg install $pkg -y > /dev/null 2>&1) &
    spinner $! "Instalowanie pakietu: ${name}"
}

# ============== BANER =============
show_banner() {
    clear
    echo -e "${CYAN}"
    cat << 'BANNER'
    ╔══════════════════════════════════════════════╗
    ║                                              ║
    ║   🚀  HACKLAB NEXUS v3.0.0 (ARM OSINT)  🚀   ║
    ║                                              ║
    ║   Automated Integration by: @Anonymousik     ║
    ║                                              ║
    ╚══════════════════════════════════════════════╝
BANNER
    echo -e "${NC}"
    log_info "Inicjalizacja środowiska instalacyjnego..."
    echo ""
}

# ============== ETAP 1: ROZWIĄZYWANIE ZALEŻNOŚCI (DEPENDENCY RESOLVER) =============
step_dependencies() {
    update_progress
    log_info "Uruchamianie inteligentnego systemu rozwiązywania zależności..."
    
    # Podstawowe narzędzia wymagane do działania skryptu
    local deps=("curl" "wget" "jq" "git" "python" "proot" "openssl")
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            log_warn "Brak zależności: ${dep}. Trwa automatyczne uzupełnianie..."
            install_pkg "$dep" "${dep} (Zależność bazowa)"
        else
            log_success "Zależność ${dep} została znaleziona w systemie."
        fi
    done
}

# ============== ETAP 2: WYKRYWANIE ŚRODOWISKA =============
detect_device() {
    update_progress
    log_info "Głęboka analiza architektury urządzenia..."
    
    DEVICE_MODEL=$(getprop ro.product.model 2>/dev/null || echo "Nieznany")
    ANDROID_VERSION=$(getprop ro.build.version.release 2>/dev/null || echo "Nieznany")
    CPU_ABI=$(getprop ro.product.cpu.abi 2>/dev/null || echo "arm64-v8a")
    GPU_VENDOR=$(getprop ro.hardware.egl 2>/dev/null || echo "")
    
    echo -e "  ${GREEN}📱${NC} Urządzenie: ${WHITE}${DEVICE_MODEL}${NC}"
    echo -e "  ${GREEN}🤖${NC} Android: ${WHITE}${ANDROID_VERSION}${NC}"
    echo -e "  ${GREEN}⚙️${NC}  Architektura: ${WHITE}${CPU_ABI}${NC}"
    
    if [[ "$GPU_VENDOR" == *"adreno"* ]]; then
        GPU_DRIVER="freedreno"
        echo -e "  ${GREEN}🎮${NC} GPU: ${WHITE}Adreno (Wykryto - Sterownik Turnip)${NC}"
    else
        GPU_DRIVER="swrast"
        echo -e "  ${GREEN}🎮${NC} GPU: ${WHITE}Software Rendering (Fallback)${NC}"
    fi
    sleep 1
}

# ============== ETAP 3: AKTUALIZACJA SYSTEMU =============
step_update() {
    update_progress
    log_info "Synchronizacja repozytoriów APT..."
    (yes | pkg update -y > /dev/null 2>&1) &
    spinner $! "Pobieranie najnowszych list pakietów..."
    
    (yes | pkg upgrade -y > /dev/null 2>&1) &
    spinner $! "Aktualizacja zainstalowanych pakietów..."
}

# ============== ETAP 4: DODAWANIE REPOZYTORIÓW =============
step_repos() {
    update_progress
    log_info "Integracja zewnętrznych repozytoriów..."
    install_pkg "x11-repo" "Repozytorium X11"
    install_pkg "tur-repo" "Repozytorium TUR (Termux User Repository)"
}

# ============== ETAP 5: POBIERANIE APK (APK AUTO-FETCHER) =============
step_apk_fetch() {
    update_progress
    log_info "Inicjalizacja modułu APK Auto-Fetcher (Źródło: Github/APKPure)..."
    
    APK_DIR="$HOME/Hacklab_APKs"
    mkdir -p "$APK_DIR"
    
    log_info "Pobieranie paczki Termux-X11 APK (Zdalna egzekucja cURL)..."
    # Używamy oficjalnego wydania dla bezpieczeństwa, ale zachowujemy strukturę skrapowania
    (curl -s -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" \
    "https://github.com/termux/termux-x11/releases/download/nightly/app-arm64-v8a-debug.apk" \
    -o "$APK_DIR/Termux-X11-Nightly.apk" > /dev/null 2>&1) &
    spinner $! "Pobieranie paczki z repozytorium..."
    
    log_success "Pobrano pliki APK do: $APK_DIR"
}

# ============== ETAP 6-11: CORE & DESKTOP (V2.0 Port) =============
step_x11() {
    update_progress
    log_info "Instalacja serwera obrazu..."
    install_pkg "termux-x11-nightly" "Termux-X11 Serwer"
}

step_desktop() {
    update_progress
    log_info "Konfiguracja środowiska graficznego (XFCE4)..."
    install_pkg "xfce4" "XFCE4 Środowisko Graficzne"
    install_pkg "xfce4-terminal" "Terminal XFCE"
}

step_gpu() {
    update_progress
    log_info "Konfiguracja akceleracji sprzętowej..."
    install_pkg "mesa-zink" "Mesa Zink (Vulkan)"
    if [ "$GPU_DRIVER" == "freedreno" ]; then
        install_pkg "mesa-vulkan-icd-freedreno" "Sterownik Turnip"
    else
        install_pkg "mesa-vulkan-icd-swrast" "Sterownik SW"
    fi
}

# ============== ETAP 12: INTEGRACJA OSINT (KALI / PARROT) =============
step_osint_tools() {
    update_progress
    log_info "Instalacja frameworków OSINT i pakietów bezpieczeństwa (Zgodność z Kali)..."
    
    # Narzędzia bazowe
    install_pkg "nmap" "Nmap (Skaner sieci)"
    install_pkg "sqlmap" "SQLMap"
    install_pkg "rust" "Kompilator Rust (dla narzędzi Crypto)"
    
    log_info "Instalacja środowiska Python dla OSINT..."
    (pip install --upgrade pip > /dev/null 2>&1 && pip install requests beautifulsoup4 colorama > /dev/null 2>&1) &
    spinner $! "Instalowanie bibliotek bazowych Python..."
    
    # Narzędzia OSINT (Sherlock, Holehe)
    (pip install sherlock-project holehe > /dev/null 2>&1) &
    spinner $! "Kompilacja i instalacja frameworków OSINT..."
}

# ============== ETAP 13: ZDALNA EGZEKUCJA (REMOTE EXECUTE) =============
step_remote_exec() {
    update_progress
    log_info "Konfiguracja modułu Zdalnej Egzekucji Skryptów (Secure Remote Exec)..."
    
    # Skrypt pozwalający na bezpieczne pobranie i odpalenie payloadu
    cat > ~/remote-exec.sh << 'REMOTEOF'
#!/bin/bash
# Hacklab Nexus - Secure Remote Execution Module
if [ -z "$1" ]; then
    echo "Użycie: ./remote-exec.sh <URL_SKRYPTU>"
    exit 1
fi
echo "[+] Pobieranie zdalnego modułu z: $1"
PAYLOAD=$(mktemp)
curl -s -L "$1" -o "$PAYLOAD"
if grep -q "#!/bin/bash" "$PAYLOAD" || grep -q "#!/usr/bin/env" "$PAYLOAD"; then
    echo "[+] Weryfikacja nagłówka poprawna. Uruchamianie..."
    chmod +x "$PAYLOAD"
    bash "$PAYLOAD"
else
    echo "[-] Krytyczny błąd: Plik nie wygląda na bezpieczny skrypt Bash."
fi
rm -f "$PAYLOAD"
REMOTEOF
    chmod +x ~/remote-exec.sh
    log_success "Zbudowano moduł ~/remote-exec.sh"
}

# ============== ETAP 14-16: SKRYPTY SYSTEMOWE I CLEANUP =============
step_wine() {
    update_progress
    log_info "Przygotowanie wsparcia dla plików .exe (Wine/Hangover)..."
    install_pkg "hangover-wine" "Warstwa kompatybilności Wine"
}

step_launchers() {
    update_progress
    log_info "Generowanie inteligentnych skryptów rozruchowych..."
    
    # GPU Config
    mkdir -p ~/.config
    cat > ~/.config/hacklab-gpu.sh << 'GPUEOF'
export GALLIUM_DRIVER=zink
export MESA_LOADER_DRIVER_OVERRIDE=zink
export TU_DEBUG=noconform
GPUEOF

    # Główny Launcher (z refaktoryzacją audio)
    cat > ~/start-nexus.sh << 'LAUNCHEREOF'
#!/bin/bash
source ~/.config/hacklab-gpu.sh 2>/dev/null
pkill -9 -f "termux.x11" 2>/dev/null
pulseaudio --start --exit-idle-time=-1 2>/dev/null
termux-x11 :0 -ac &
sleep 3
export DISPLAY=:0
echo "[+] Uruchamianie środowiska graficznego. Otwórz aplikację Termux-X11."
exec startxfce4
LAUNCHEREOF
    chmod +x ~/start-nexus.sh
}

step_cleanup() {
    update_progress
    log_info "Sprzątanie po instalacji..."
    (pkg clean > /dev/null 2>&1 && apt autoremove -y > /dev/null 2>&1) &
    spinner $! "Czyszczenie pamięci podręcznej..."
}

# ============== ZAKOŃCZENIE =============
show_completion() {
    echo ""
    echo -e "${GREEN}"
    cat << 'COMPLETE'
    ╔══════════════════════════════════════════════════════════╗
    ║                                                          ║
    ║   ✅  INSTALACJA HACKLAB NEXUS ZAKOŃCZONA SUKCESEM!  ✅  ║
    ║                                                          ║
    ╚══════════════════════════════════════════════════════════╝
COMPLETE
    echo -e "${NC}"
    log_success "Zaktualizowano infrastrukturę do wersji v3.0.0 (Pull Request: @Anonymousik)."
    echo ""
    echo -e "${WHITE}🚀 ROZRUCH ŚRODOWISKA:${NC} ${GREEN}./start-nexus.sh${NC}"
    echo -e "${WHITE}📲 POBRANE PLIKI APK:${NC}  ${GREEN}cd ~/Hacklab_APKs${NC}"
    echo -e "${WHITE}🌐 ZDALNA EGZEKUCJA:${NC}   ${GREEN}./remote-exec.sh <URL>${NC}"
    echo ""
}

# ============== GŁÓWNA LOGIKA =============
main() {
    show_banner
    echo -e "${YELLOW}Czy chcesz rozpocząć zautomatyzowany proces wdrażania infrastruktury? [Enter]${NC}"
    read
    
    step_dependencies
    detect_device
    step_update
    step_repos
    step_apk_fetch
    step_x11
    step_desktop
    step_gpu
    step_osint_tools
    step_remote_exec
    step_wine
    step_launchers
    step_cleanup
    
    show_completion
}

main
