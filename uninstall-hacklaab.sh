#!/data/data/com.termux/files/usr/bin/bash
#########################################################
# 🗑️ MOBILE HACKING LAB - Uninstaller v2.0
# Removes all components installed by the installer
#
# Author: Uninstaller Generator
# Based on Mobile HackLab Installer v2.0
#########################################################

# ============== COLORS ==============
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
NC='\033[0m'

# ============== BANNER ==============
show_banner() {
    clear
    echo -e "${RED}"
    cat << 'BANNER'
╔══════════════════════════════════════╗
║                                      ║
║ 🗑️ MOBILE HACKLAB UNINSTALLER 🗑️    ║
║                                      ║
║     Remove All Components            ║
║                                      ║
╚══════════════════════════════════════╝
BANNER
    echo -e "${NC}"
    echo -e "${WHITE} This will remove all installed components.${NC}"
    echo ""
}

# ============== CONFIRMATION ==============
confirm_uninstall() {
    echo -e "${YELLOW}⚠️  WARNING: This will remove:${NC}"
    echo -e "  • All hacking tools and desktop environment"
    echo -e "  • Custom scripts and configurations"
    echo -e "  • Wine and Windows compatibility layer"
    echo -e "  • GPU acceleration configs"
    echo ""
    echo -e "${RED}This action cannot be undone!${NC}"
    echo ""
    read -p "$(echo -e "${WHITE}Type 'UNINSTALL' to confirm: ${NC}")" confirm
    
    if [ "$confirm" != "UNINSTALL" ]; then
        echo -e "${YELLOW}Uninstall cancelled.${NC}"
        exit 0
    fi
}

# ============== STOP RUNNING PROCESSES ==============
stop_processes() {
    echo ""
    echo -e "${PURPLE}[*] Stopping running processes...${NC}"
    
    # Stop X11
    pkill -9 -f "termux.x11" 2>/dev/null
    pkill -9 -f "xfce" 2>/dev/null
    pkill -9 -f "pulseaudio" 2>/dev/null
    pkill -9 -f "dbus" 2>/dev/null
    pkill -9 -f "wine" 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Processes stopped"
}

# ============== REMOVE SCRIPTS ==============
remove_scripts() {
    echo ""
    echo -e "${PURPLE}[*] Removing custom scripts...${NC}"
    
    # Remove launcher scripts
    rm -f ~/start-hacklab.sh
    rm -f ~/hacktools.sh
    rm -f ~/stop-hacklab.sh
    rm -f ~/.config/hacklab-gpu.sh
    
    # Remove bashrc entry
    if [ -f ~/.bashrc ]; then
        sed -i '/hacklab-gpu.sh/d' ~/.bashrc
        sed -i '/Mobile HackLab/d' ~/.bashrc
    fi
    
    echo -e " ${GREEN}✓${NC} Scripts removed"
}

# ============== REMOVE DESKTOP SHORTCUTS ==============
remove_shortcuts() {
    echo ""
    echo -e "${PURPLE}[*] Removing desktop shortcuts...${NC}"
    
    rm -rf ~/Desktop/*.desktop 2>/dev/null
    rmdir ~/Desktop 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Shortcuts removed"
}

# ============== REMOVE WINE ==============
remove_wine() {
    echo ""
    echo -e "${PURPLE}[*] Removing Wine components...${NC}"
    
    # Remove symlinks
    rm -f /data/data/com.termux/files/usr/bin/wine
    rm -f /data/data/com.termux/files/usr/bin/winecfg
    
    # Remove Wine packages
    pkg uninstall hangover-wine -y 2>/dev/null
    pkg uninstall hangover-wowbox64 -y 2>/dev/null
    
    # Remove Wine directory
    rm -rf ~/.wine 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Wine removed"
}

# ============== REMOVE SECURITY TOOLS ==============
remove_security_tools() {
    echo ""
    echo -e "${PURPLE}[*] Removing security tools...${NC}"
    
    pkg uninstall hydra -y 2>/dev/null
    pkg uninstall john -y 2>/dev/null
    pkg uninstall sqlmap -y 2>/dev/null
    
    # Remove Python security libraries
    pip uninstall requests -y 2>/dev/null
    pip uninstall beautifulsoup4 -y 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Security tools removed"
}

# ============== REMOVE METASPLOIT ==============
remove_metasploit() {
    echo ""
    echo -e "${PURPLE}[*] Removing Metasploit Framework...${NC}"
    
    pkg uninstall metasploit -y 2>/dev/null
    rm -rf ~/metasploit-framework 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Metasploit removed"
}

# ============== REMOVE NETWORK TOOLS ==============
remove_network_tools() {
    echo ""
    echo -e "${PURPLE}[*] Removing network tools...${NC}"
    
    pkg uninstall nmap -y 2>/dev/null
    pkg uninstall netcat-openbsd -y 2>/dev/null
    pkg uninstall whois -y 2>/dev/null
    pkg uninstall dnsutils -y 2>/dev/null
    pkg uninstall tracepath -y 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Network tools removed"
}

# ============== REMOVE APPLICATIONS ==============
remove_apps() {
    echo ""
    echo -e "${PURPLE}[*] Removing applications...${NC}"
    
    pkg uninstall firefox -y 2>/dev/null
    pkg uninstall code-oss -y 2>/dev/null
    pkg uninstall git -y 2>/dev/null
    pkg uninstall wget -y 2>/dev/null
    pkg uninstall curl -y 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Applications removed"
}

# ============== REMOVE AUDIO ==============
remove_audio() {
    echo ""
    echo -e "${PURPLE}[*] Removing audio support...${NC}"
    
    pulseaudio --kill 2>/dev/null
    pkg uninstall pulseaudio -y 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Audio removed"
}

# ============== REMOVE GPU DRIVERS ==============
remove_gpu() {
    echo ""
    echo -e "${PURPLE}[*] Removing GPU acceleration...${NC}"
    
    pkg uninstall mesa-zink -y 2>/dev/null
    pkg uninstall mesa-vulkan-icd-freedreno -y 2>/dev/null
    pkg uninstall mesa-vulkan-icd-swrast -y 2>/dev/null
    pkg uninstall vulkan-loader-android -y 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} GPU drivers removed"
}

# ============== REMOVE DESKTOP ==============
remove_desktop() {
    echo ""
    echo -e "${PURPLE}[*] Removing XFCE4 Desktop...${NC}"
    
    pkg uninstall xfce4 -y 2>/dev/null
    pkg uninstall xfce4-terminal -y 2>/dev/null
    pkg uninstall thunar -y 2>/dev/null
    pkg uninstall mousepad -y 2>/dev/null
    
    # Remove XFCE config
    rm -rf ~/.config/xfce4 2>/dev/null
    rm -rf ~/.cache/xfce4 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Desktop removed"
}

# ============== REMOVE X11 ==============
remove_x11() {
    echo ""
    echo -e "${PURPLE}[*] Removing Termux-X11...${NC}"
    
    pkg uninstall termux-x11-nightly -y 2>/dev/null
    pkg uninstall xorg-xrandr -y 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} X11 removed"
}

# ============== REMOVE REPOSITORIES ==============
remove_repos() {
    echo ""
    echo -e "${PURPLE}[*] Removing package repositories...${NC}"
    
    pkg uninstall tur-repo -y 2>/dev/null
    pkg uninstall x11-repo -y 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Repositories removed"
}

# ============== CLEANUP ==============
cleanup() {
    echo ""
    echo -e "${PURPLE}[*] Cleaning up...${NC}"
    
    # Remove config directory
    rm -rf ~/.config/hacklab* 2>/dev/null
    
    # Clean package cache
    pkg clean 2>/dev/null
    
    # Remove any remaining files
    rm -rf ~/.local/share/xfce4 2>/dev/null
    rm -rf ~/.xsessions 2>/dev/null
    rm -rf ~/.xsession-errors 2>/dev/null
    
    echo -e " ${GREEN}✓${NC} Cleanup complete"
}

# ============== COMPLETION ==============
show_completion() {
    echo ""
    echo -e "${GREEN}"
    cat << 'COMPLETE'
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║           ✅ UNINSTALLATION COMPLETE! ✅                      ║
║                                                               ║
║           All components have been removed.                  ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
COMPLETE
    echo -e "${NC}"
    echo -e "${WHITE}📱 Mobile HackLab has been completely removed.${NC}"
    echo ""
    echo -e "${YELLOW}Note: Termux itself is still installed.${NC}"
    echo -e "${YELLOW}If you want to reset Termux completely:${NC}"
    echo -e "  ${GREEN}pkg install termux-tools && termux-reset${NC}"
    echo ""
}

# ============== MAIN ==============
main() {
    show_banner
    confirm_uninstall
    
    stop_processes
    remove_scripts
    remove_shortcuts
    remove_wine
    remove_security_tools
    remove_metasploit
    remove_network_tools
    remove_apps
    remove_audio
    remove_gpu
    remove_desktop
    remove_x11
    remove_repos
    cleanup
    
    show_completion
}

# ============== RUN ==============
main
