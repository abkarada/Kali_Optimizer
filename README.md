# Kali Optimizer

**Kali Optimizer** is a modular Linux toolkit designed to optimize Kali Linux for specific use cases. It provides both a command-line interface and a terminal-based graphical interface (Ncurses TUI) for selecting operational modes like daily use, pentesting, forensics, wireless auditing, and system hardening.

---

## Why Kali Optimizer?
Manually configuring Kali Linux after installation is time-consuming and often repetitive. This project automates the optimization process based on your current use case and provides an intuitive interface to choose your desired mode.

---

## ⚙️ Features

- Modular Bash script with support for:
  - **Daily Use Mode** – GUI apps, firewall setup, service cleanup
  - **Pentesting Mode** – Installs top security tools, enables services
  - **Forensics Mode** – Disables logs, swap, sets mount behavior
  - **Wireless Audit Mode** – Installs wireless tools, enables monitor mode
  - **Stealth/Hardening Mode** – MAC spoofing, kernel hardening, disables telemetry
- Ncurses-based TUI (`kali_mode_gui`) for easy navigation
- Safe mode switching with clear logging and visual feedback

---

## 🖥️ Interface Versions

### 1. **Command-line version**
Run directly from terminal:
```bash
./kali_optimize.sh <mode>
```
Example:
```bash
./kali_optimize.sh pentest
```

### 2. **Graphical terminal version (Ncurses GUI)**
Build and run:
```bash
gcc -o kali_mode_gui kali_mode_gui.c -lncurses
./kali_mode_gui
```
Navigate using arrow keys and press Enter to apply a mode.

---

## 📁 File Structure
```
kali_optimizer/
├── kali_optimize.sh        # Main modular script
├── kali_mode_gui.c         # TUI menu with ncurses
├── daily_mode.sh           # (Optional wrapper)
├── pentest_mode.sh         # (Optional wrapper)
├── forensics_mode.sh       # (Optional wrapper)
├── wireless_mode.sh        # (Optional wrapper)
├── stealth_mode.sh         # (Optional wrapper)
├── LICENSE                 # GPL v3 License
├── README.md               # This file
```

---

## Quick Start
```bash
git clone https://github.com/abkarada/kali_optimizer.git
cd kali_optimizer
chmod +x *.sh
./kali_optimize.sh daily        # OR
./kali_mode_gui                 # after compiling
```

---

## License
This project is licensed under the GNU GPL v3. See `LICENSE` for details.

---

## ‍💻 Author
**Abdurrahman Karadağ**  
Crafted for sysadmins, pentesters, and system tinkerers alike. 
