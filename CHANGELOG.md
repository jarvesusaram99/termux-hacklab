` HACKLAB ANDROID EXENDED v3.0.0 `
# Changelog
All notable changes to this project will be documented in this file.
The format is based on Keep a Changelog,
and this project adheres to Semantic Versioning.
## [3.0.0] - 2026-05-17
### Added
 * **Intelligent Dependency Resolver:** Pre-execution verification engine checking for essential binaries (curl, wget, jq, git, python, proot, openssl) and installing them automatically.
 * **APK Auto-Fetcher Engine:** Scraper and downloader utility configured to pull verified helper APK packages to the ~/Hacklab_APKs directory.
 * **Natively Integrated OSINT Suite:** Integrated security tools like Nmap, SQLMap, and Python-based utilities (Sherlock, Holehe) into the base installation.
 * **Secure Remote Script Execution Module:** Introduced the ~/remote-exec.sh launcher to fetch and validate remote payloads before running them.
 * **Multi-lingual Log Interface (i18n ready):** Added structured console output logging classes separating operational, error, warning, and success logs.
### Fixed
 * **Cleanup Fault Tolerance:** Fixed the deinstallation sequence in uninstall.sh to safely target and terminate orphan graphical server processes and lingering background daemons.
 * **Registry and Audio Configuration Hooks:** Corrected Registry rendering anomalies for Wine and PulseAudio-to-TCP authorization settings.
### Changed
 * **Code Refactoring:** Re-architected both install.sh and uninstall.sh to support modular procedures instead of inline linear scripting.
 * **GPU Path Fallbacks:** Dynamic fallback detection routines configured to direct non-Qualcomm GPUs safely to software-rasterized (swrast) rendering loops without throwing termination errors.
### Removed
 * **Static Configuration Directories:** Removed hardcoded local path declarations in favor of environment-variable-driven paths ($HOME, $PREFIX).
