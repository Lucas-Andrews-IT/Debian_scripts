#!/bin/bash

# This script will prompt the user to enter the maximum size of Docker storage and the directory path where Docker storage will be saved. 
# The script creates the Docker daemon configuration file based on the user's input and reloads the Docker daemon configuration to enable the new settings. 
# The script installs Docker on the system and enables Docker at boot time.


echo "Starting Docker installation..."

# Update the system
sudo apt-get update

# Install Docker and related dependencies
sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg \
     lsb-release -y

# Add Docker's GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the system
sudo apt-get update

# Install Docker Engine
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Enable Docker at boot
sudo systemctl enable docker

# Prompt the user for Docker configuration
echo "Enter the Docker configuration settings: "
read -p "Enter the maximum size of Docker storage (in GB): " max_size
read -p "Enter the Docker storage directory path: " storage_dir

# Create the Docker daemon configuration file
cat << EOF | sudo tee /etc/docker/daemon.json > /dev/null
{
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true",
    "overlay2.size=${max_size}GB"
  ],
  "data-root": "${storage_dir}"
}
EOF

# Reload Docker daemon configuration
sudo systemctl daemon-reload
sudo systemctl restart docker

echo "Docker installation complete!"
