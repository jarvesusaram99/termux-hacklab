# 📱 Hacklab Nexus v3.0.0 (ARM OSINT Framework)
### Run Linux Desktop, GPU Acceleration & OSINT Tools on Android
> An automated integration framework that transforms your Android device into a professional intelligence-gathering (OSINT) workstation and security testing platform. Authorized Pull Request.
> 
## 🚀 One-Command Deployment
<img width="876" height="721" alt="1000464163" src="https://github.com/user-attachments/assets/f77c3736-8e12-4497-984a-5a622fd2b6ac" />

Open **Termux** and paste the following command:
```bash
curl -sL 'https://raw.githubusercontent.com/anonymousik/termux-hlabExt/main/install.sh' | bash
```

## 🗑️ One-Command uninstaller 
Open **Termux** and paste the following command:
```bash
curl -sL 'https://raw.githubusercontent.com/anonymousik/termux-hlabExt/main/uninstall-hacklab.sh' | bash
```

### Quick Apply: Firefox X11 Crash Patch (Samsung SoCs)

If you are experiencing Termux-X11 crashes while watching YouTube in Firefox on Android 16 (specifically Samsung/Exynos devices), your GPU translation layer (Zink/Turnip) is failing to allocate hardware video buffers via VA-API. 

This automated patch modifies your Firefox profile to forcefully utilize a highly stable software decoder (FFvpx) for media playback, entirely bypassing the hardware API while maintaining WebRender UI acceleration.

**Apply instantly via `curl` (Recommended):**
```bash
curl -sSL https://raw.githubusercontent.com/anonymousik/termux-hlabExt/main/patch_ff_x11.sh | bash
```

**Alternative application via `wget`:**

```bash
wget -qO- https://raw.githubusercontent.com/anonymousik/termux-hlabExt/main/patch_ff_x11.sh | bash
```

**Post-Installation:**
The script automatically injects the necessary configurations into `~/.mozilla/firefox/` and exports `MOZ_DISABLE_VAAPI=1` to your shell RC files. Please restart your terminal session or run source `~/.bashrc` for changes to take effect.


## ✨ Features & Architecture Upgrades in v3.0.0 (by @Anonymousik)
Version 3.0.0 shifts Hacklab from a basic installation script to an automated, intelligent workspace:

| Feature | Technical Description |
| :--- | :--- |
| 🤖 **Dependency Resolver** | Analyzes local binaries (curl, wget, jq, git, etc.) and automatically fixes system gaps before execution. |
| 📦 **APK Auto-Fetcher** | Scrapes, validates, and downloads critical Android companion packages (such as Termux-X11) to ~/Hacklab_APKs. |
| 🕵️‍♂️ **OSINT Frameworks** | Native integration of top-tier Kali/Parrot OSINT toolsets including Sherlock, Holehe, Nmap, and SQLMap. |
| 📡 **Remote Execute Engine** | A secure runner module allowing remote execution of verified cryptographic and deployment scripts. |
| 🌐 **Structured Logging (i18n)** | High-grade logging architecture separating standard outputs into unified terminal feedback streams (INFO, WARN, ERROR, SUCCESS). | <br> ## 🖥️ Graphic Subsystem & Hardware Acceleration <br> Unlike standard solutions running sluggish software rendering over VNC, Hacklab Nexus leverages **native hardware GPU acceleration**: <br> * Configured to use **Mesa Zink** (OpenGL over Vulkan abstraction layer). <br> * Native integration with **Turnip Adreno drivers** for Qualcomm-based units. <br> * Delivers a smooth desktop environment at a stable 60 FPS with minimal thermal and battery impact. <br> ## 🛠️ Command Reference & Operational Workflow <br> Post-installation, utilize these generated system executables and configurations within your home directory:
| Command | Action / Operational Context |
| :--- | :--- |
| ./start-nexus.sh | 🖥️ Starts the XFCE4 desktop instance and initializes the local Termux-X11 server. |
| ./remote-exec.sh <URL> | 📡 Dynamically fetches, validates headers, and securely runs remote Bash files. |
| cd ~/Hacklab_APKs | 📁 Quick access to fetched .apk installers for local deployment. |
| ./uninstall-hacklab.sh | 🛑 Safely wipes environmental modifications, executing a full clean state rollback. |

## 📋 System Prerequisites
 * **OS Platform:** Android 7.0 or higher (Android 10+ recommended for stable Vulkan loader support).
 * **Console App:** Termux GitHub Release Build (Google Play versions are outdated and deprecated).
 * **Physical Memory:** Minimum 4GB of free local storage.
## ⚠️ Disclaimer
```text
This tool is intended for EDUCATIONAL, RESEARCH, AND AUTHORIZED PENETRATION TESTING PURPOSES ONLY.
Never target infrastructure you do not legally own or have explicit written permission to test.
Unauthorized cyber-operations are illegal. The contributors accept no liability for misuse.
```
<p align="center">
<b>🔥 Hacklab Nexus v3.0.0 - Tailored for ARM & updated by @Anonymousik 🔥</b>
</p>
``
Anonymousik.is-a.dev
``
