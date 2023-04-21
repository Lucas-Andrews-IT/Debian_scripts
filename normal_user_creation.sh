#!/bin/bash

# Get the username
read -p "Enter the username: " username

# Get the password
read -sp "Enter the password: " password

# Create the user
useradd -m $username

# Set the password for the user
echo "$username:$password" | chpasswd

echo "User '$username' created successfully!"
