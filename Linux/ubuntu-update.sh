#!/bin/bash

# Title: Ubuntu System Update Script
# Description: Updates and upgrades system packages, cleans unnecessary files

echo "--------------------------------------"
echo "🔄 Starting Ubuntu System Update..."
echo "--------------------------------------"

# Update package list
sudo apt update -y

# Upgrade all packages
sudo apt upgrade -y

# Full upgrade including kernel & dependencies
sudo apt full-upgrade -y

# Remove unused dependencies
sudo apt autoremove -y

# Clean up downloaded .deb files
sudo apt autoclean -y
sudo apt clean -y

echo "--------------------------------------"
echo "✅ System update and cleanup completed!"
echo "--------------------------------------"

# Optional: Reboot prompt
read -p "🔁 Do you want to reboot now? (y/n): " choice
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
  echo "Rebooting..."
  sudo reboot
else
  echo "You can reboot later using: sudo reboot"
fi

