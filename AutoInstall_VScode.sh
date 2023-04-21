#!/bin/bash

# Update package list and upgrade packages
sudo apt update
sudo apt upgrade -y

# Install Visual Studio Code
sudo apt install -y software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install -y code

# Install Python and SQL extensions
code --install-extension ms-python.python
code --install-extension ms-mssql.mssql

# Prompt user for defined settings
read -p "Enter your preferred theme: " theme
code --install-extension $theme

read -p "Enter your preferred font: " font
code --install-extension $font

read -p "Enter your preferred indent size: " indent
sed -i 's/"editor.tabSize": 4/"editor.tabSize": '$indent'/g' ~/.config/Code/User/settings.json

echo "Visual Studio Code has been installed and configured for your software development environment!"
