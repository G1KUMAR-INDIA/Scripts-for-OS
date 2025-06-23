#!/bin/bash

# Ubuntu System Optimizer Script
# Author: R Jeevan Kumar (rjeevankumar.dev)
# Tested on: Ubuntu 22.04+

set -e

echo "🔄 Updating package lists..."
sudo apt update

echo "⬆️ Upgrading installed packages..."
sudo apt upgrade -y

echo "🧹 Removing unnecessary packages..."
sudo apt autoremove -y
sudo apt autoclean

echo "🧼 Cleaning system cache..."
sudo journalctl --vacuum-time=7d

echo "🧠 Optimizing system swappiness (temporary, until reboot)..."
sudo sysctl vm.swappiness=10

# Make it permanent
if ! grep -q "vm.swappiness" /etc/sysctl.conf; then
    echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
fi

echo "🔒 Enabling UFW firewall..."
sudo ufw enable
sudo ufw allow OpenSSH

echo "💽 Checking and enabling SSD TRIM (if supported)..."
if [ -x "$(command -v fstrim)" ]; then
    sudo systemctl enable fstrim.timer
    sudo systemctl start fstrim.timer
    echo "✅ SSD TRIM enabled."
else
    echo "⚠️ fstrim not installed or SSD not detected."
fi

echo "✅ Optimization complete!"

