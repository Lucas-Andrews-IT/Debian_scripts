#!/bin/bash

# Update package list
sudo apt update

# Install Discord
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb
sudo apt install -f

# Install Bitwarden
wget -O bitwarden.deb "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb"
sudo dpkg -i bitwarden.deb
sudo apt install -f

# Install Brave web browser
sudo apt install apt-transport-https curl gnupg
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# Clean up
rm discord.deb bitwarden.deb
