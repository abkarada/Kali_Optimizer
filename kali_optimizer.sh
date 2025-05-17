#!/bin/bash

set -e

info()    { echo -e "\e[36m[INFO]\e[0m $1"; }
success() { echo -e "\e[32m[SUCCESS]\e[0m $1"; }
error()   { echo -e "\e[31m[ERROR]\e[0m $1"; }

info "Kali Optimizer starting..."
sleep 1

echo "Choose Mode:" 
echo "[1] Daily Use"
echo "[2] Penetration Testing"
echo "[3] Forensics"
echo "[4] Wireless Audit"
echo "[5] Stealth / Hardening"
read -p "Select a mode (1-5): " mode

if [[ "$mode" == "1" ]]; then
  info "Applying Daily Use Optimizations..."
  sudo apt update && sudo apt upgrade -y
  sudo apt install -y firefox-esr gnome-software neofetch git curl ufw gdebi unzip
  sudo ufw enable
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo systemctl disable bluetooth.service cups.service
  success "Daily use optimization complete."

elif [[ "$mode" == "2" ]]; then
  info "Applying Penetration Testing Configuration..."
  sudo apt update && sudo apt full-upgrade -y
  sudo apt install -y metasploit-framework gobuster seclists bloodhound crackmapexec \
    enum4linux exploitdb john hydra nikto nmap sqlmap wfuzz feroxbuster eyewitness \
    net-tools whois aircrack-ng hashcat python3-pip
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo systemctl set-default multi-user.target
  success "Pentesting mode setup complete."

elif [[ "$mode" == "3" ]]; then
  info "Activating Forensics Mode..."
  sudo swapoff -a
  sudo systemctl stop rsyslog auditd
  sudo systemctl disable rsyslog auditd
  success "Forensics environment prepared."

elif [[ "$mode" == "4" ]]; then
  info "Setting Up Wireless Audit Tools..."
  sudo apt update && sudo apt install -y aircrack-ng reaver bully hcxdumptool bettercap
  sudo rfkill unblock wifi
  sudo airmon-ng check kill
  sudo ip link set wlan0 down && sudo iw dev wlan0 set type monitor && sudo ip link set wlan0 up
  success "Wireless tools ready. Monitor mode enabled."

elif [[ "$mode" == "5" ]]; then
  info "Applying Stealth / Hardening Settings..."
  sudo apt install -y macchanger
  sudo macchanger -r eth0
  echo "net.ipv4.ip_forward=0" | sudo tee -a /etc/sysctl.conf
  echo "kernel.kptr_restrict=2" | sudo tee -a /etc/sysctl.conf
  echo "kernel.randomize_va_space=2" | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
  sudo systemctl disable bluetooth avahi-daemon cups
  sudo apt purge -y popularity-contest apport whoopsie
  success "Stealth/hardening settings applied."

else
  error "Invalid selection. Please rerun the script and choose between 1-5."
  exit 1
fi

