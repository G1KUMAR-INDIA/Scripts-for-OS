#!/bin/bash

# Update and upgrade system
echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

# Install common utilities
echo "⚙️ Installing core utilities..."
sudo apt install -y wget curl git build-essential gnome-tweaks gparted vlc python3 python3-pip

# Install Google Chrome
echo "🌐 Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Install Zoom
echo "🎥 Installing Zoom..."
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb
rm zoom_amd64.deb

# Install VS Code
echo "📝 Installing VS Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
rm packages.microsoft.gpg

# Install Node.js and npm
echo "📦 Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# (Optional) Install Docker
read -p "💡 Do you want to install Docker? (y/n): " docker_install
if [[ "$docker_install" == "y" || "$docker_install" == "Y" ]]; then
    echo "🐳 Installing Docker..."
    sudo apt install -y docker.io docker-compose
    sudo systemctl enable --now docker
    sudo usermod -aG docker $USER
    echo "ℹ️ Docker installed. Please log out and back in to use Docker without sudo."
fi

echo "✅ Developer setup complete!"
