#!/usr/bin/env bash
# Skrypt wdrażający łatkę stabilności dla Firefoxa w Termux-X11 (Hacklab v3.0)
# Eliminuje crash serwera X wywołany brakiem obsługi sprzętowego VA-API przez Zink

set -euo pipefail

FIREFOX_DIR="$HOME/.mozilla/firefox"
RC_FILES=("$HOME/.bashrc" "$HOME/.zshrc")

echo "[*] Rozpoczynam aplikowanie łatki dla błędu Zink/Turnip (Samsung)..."

# 1. Walidacja obecności środowiska Firefox
if [[ ! -d "$FIREFOX_DIR" ]]; then
    echo "[-] BŁĄD: Nie znaleziono katalogu $FIREFOX_DIR. Uruchom przeglądarkę przed uruchomieniem łatki." >&2
    exit 1
fi

# 2. Wstrzyknięcie bezpiecznej konfiguracji (Wyłączenie VA-API, włączenie FFvpx)
for profile in "$FIREFOX_DIR"/*.default*; do
    if [[ -d "$profile" ]]; then
        USER_JS="$profile/user.js"
        echo "[*] Aktualizacja profilu: $(basename "$profile")"
        
        # Tworzenie lub dopisywanie do user.js (nadpisuje ustawienia about:config)
        cat <<EOF >> "$USER_JS"

// [HACKLAB PATCH] Rozwiązanie problemu crashu Termux-X11 podczas odtwarzania wideo
user_pref("media.hardware-video-decoding.enabled", false);
user_pref("media.ffmpeg.vaapi.enabled", false);
user_pref("media.ffvpx.enabled", true);
EOF
        echo "[+] Pomyślnie zaktualizowano plik $USER_JS"
    fi
done

# 3. Dodanie wymuszenia zmiennej środowiskowej w powłokach
apply_env_var() {
    local rc_file="$1"
    if [[ -f "$rc_file" ]]; then
        if ! grep -q "MOZ_DISABLE_VAAPI=1" "$rc_file"; then
            echo -e "\n# [HACKLAB PATCH] Obejście błędu akceleracji Firefox" >> "$rc_file"
            echo "export MOZ_DISABLE_VAAPI=1" >> "$rc_file"
            echo "[+] Wyeksportowano MOZ_DISABLE_VAAPI do $rc_file"
        else
            echo "[*] Zmienna MOZ_DISABLE_VAAPI jest już skonfigurowana w $rc_file"
        fi
    fi
}

for rc in "${RC_FILES[@]}"; do
    apply_env_var "$rc"
done

echo "[+] Łatka zaaplikowana pomyślnie. Wykonaj 'source ~/.bashrc' lub zrestartuj terminal."
