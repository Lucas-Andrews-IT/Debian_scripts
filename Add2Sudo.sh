#!/bin/bash

# Get the username of the user to add
read -p "Enter the username of the user to add to sudoers: " username

# Check if the user is already in the sudoers file
if grep -q "^$username" /etc/sudoers; then
    echo "User $username is already in the sudoers file."
else
    # Add the user to the sudoers file
    echo "User $username is not in the sudoers file. Adding..."
    echo "$username ALL=(ALL:ALL) ALL" | sudo tee -a /etc/sudoers > /dev/null
    echo "User $username has been added to the sudoers file."
fi
