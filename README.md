# 📱 Mobile HackLab
### Run Linux Desktop with GPU Acceleration on Android (No Root!)
> Turn your Android phone into a powerful hacking machine with one command!
> 
![GPU](https://img.shields.io/badge/GPU-Accelerated-orange?style=for-the-badge)
![Root](https://img.shields.io/badge/Root-Not%20Required-brightgreen?style=for-the-badge)
---
## 🚀 One-Command Installation
Open **Termux** and paste this:
```bash
curl -sL https://raw.githubusercontent.com/jarvesusaram99/termux-hacklab/main/install.sh | bash
```
**Or using wget:**
```bash
wget -O - https://raw.githubusercontent.com/jarvesusaram99/termux-hacklab/main/install.sh | bash
```
---
## ✨ Features
| Feature | Description |
|---------|-------------|
| 🖥️ **Full Linux Desktop** | XFCE4 with Termux-X11 |
| 🎮 **GPU Acceleration** | Turnip/Zink drivers for smooth 60fps |
| 🔓 **No Root Required** | Works on ANY Android phone! |
| 🔧 **100+ Hacking Tools** | Nmap, Metasploit, SQLMap, Hydra |
| 🪟 **Windows Support** | Run `.exe` apps with Wine/Hangover |
| ⌨️ **Bluetooth Support** | Keyboard & mouse work perfectly |
| 📊 **Progress Bar** | See installation progress in real-time |
| 🔊 **Audio Support** | PulseAudio for sound |
---
## 🎮 GPU Acceleration - What Makes This Special
Unlike other guides that use **slow software rendering**, this installer sets up **real GPU acceleration**:
| Without GPU Accel | With GPU Accel (This Script) |
|-------------------|------------------------------|
| llvmpipe (CPU) | **Turnip Adreno (GPU)** |
| 15-20 FPS | **60 FPS** |
| Laggy desktop | **Smooth like PC** |
| High battery drain | **Efficient** |
**Supported GPUs:**
- ✅ Qualcomm Adreno (Snapdragon phones)
- ✅ Samsung Exynos (with Mali)
- ✅ MediaTek (software fallback)
---
## 📦 What Gets Installed
### 🖥️ Desktop Environment
- XFCE4 Desktop
- Thunar File Manager
- Firefox Browser
- VS Code Editor
### 🔧 Hacking Tools
| Category | Tools |
|----------|-------|
| **Network** | Nmap, Netcat, Whois, DNS tools |
| **Web** | SQLMap, Nikto |
| **Password** | Hydra, John the Ripper |
| **Exploitation** | Metasploit Framework |
### 🪟 Windows Support
- Wine Compatibility Layer
- Hangover (WowBox64)
- Direct `.exe` execution support
### 🎮 GPU Drivers
- Mesa Zink (OpenGL over Vulkan)
- Turnip (Adreno GPU driver)
- Vulkan Loader
---
## 🎬 Video Tutorial
[![Watch on YouTube](https://img.shields.io/badge/Watch%20Full%20Tutorial-YouTube-red?style=for-the-badge&logo=youtube)](https://youtu.be/4do18nhKc2k)
**Step-by-step guide on my YouTube channel!**
---
## 📸 Installation Preview
```
╔══════════════════════════════════════╗
║                                      ║
║   🚀  MOBILE HACKLAB v2.1  🚀        ║
║                                      ║
║       Tech Jarves - YouTube          ║
║                                      ║
╚══════════════════════════════════════╝
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  📊 OVERALL PROGRESS: Step 11/13 ██████████████░░░ 84%
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Step 11/13] Installing Wine (Windows Support)...
  ✓ Removing old Wine versions...
  ✓ Installing Wine Compatibility Layer...
  ⏳ Installing Box64 Wrapper... ⠹
```
---
## 🛠️ Usage
After installation, use these commands:
| Command | What it does |
|---------|--------------|
| `bash ~/start-hacklab.sh` | 🖥️ Start the desktop |
| `bash ~/hacktools.sh` | 🔧 Quick tools menu |
| `bash ~/stop-hacklab.sh` | 🛑 Stop the desktop |
---
## 📋 Requirements
| Requirement | Details |
|-------------|---------|
| **Android** | 7.0 or higher |
| **Termux** | [Download from GitHub](https://github.com/termux/termux-app/releases) (NOT Play Store!) |
| **Termux-X11** | [Download from GitHub](https://github.com/termux/termux-x11/releases) |
| **Storage** | ~4GB free space |
| **Internet** | Required for installation |
> ⚠️ **Important:** Download Termux from GitHub, NOT Play Store! The Play Store version is outdated.
---
## 💡 Pro Tips
1. **Disable Phantom Process Killer** in Developer Options for stability
2. **Use Bluetooth keyboard/mouse** for better experience
3. **Open Termux-X11 app FIRST** before running `start-hacklab.sh`
4. **Samsung DeX** works great with this setup!
---
## ⚠️ Disclaimer
```
This tool is for EDUCATIONAL PURPOSES ONLY.
Only use on systems you own or have explicit permission to test.
Unauthorized hacking is illegal.
The author is not responsible for any misuse.
```
---
## 🤝 Contributing
Pull requests welcome! Feel free to:
- 🐛 Report bugs
- 💡 Suggest features
- 🔧 Add new tools
---
## 📺 Connect With Me
| Platform | Link |
|----------|------|
| **YouTube** | [@TechJarves](https://youtube.com/@TechJarves) |
| **GitHub** | [jarvesusaram99](https://github.com/jarvesusaram99) |
---
## ⭐ Star This Repo!
If this helped you, please give it a **star** ⭐ - it helps others find this project!
---
<p align="center">
  <b>🔥 Run Linux with GPU Acceleration - No Root Required! 🔥</b>
  <br><br>
  Made with ❤️ by <b>Tech Jarves</b>
</p>



