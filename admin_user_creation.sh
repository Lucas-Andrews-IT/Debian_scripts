#!/bin/bash

# Prompt for the username and password
read -p "Enter the username: " username
read -s -p "Enter the password: " password

# Add the user to the sudo group
echo $password | sudo -S usermod -aG sudo $username

# Check if the user was added successfully
if [ $? -eq 0 ]; then
  echo "User $username was added to sudoers file successfully."
else
  echo "Failed to add user $username to sudoers file."
fi
