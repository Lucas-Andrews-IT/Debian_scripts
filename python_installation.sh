#!/bin/bash

# Prompt user for Python version to install
read -p "Enter Python version to install (e.g. 3.9.7): " version

# Install Python
wget https://www.python.org/ftp/python/$version/Python-$version.tgz
tar -xvf Python-$version.tgz
cd Python-$version
./configure
make
sudo make install

# Prompt user for Python environment variables
read -p "Enter the name of the environment variable to set (e.g. PYTHON_HOME): " env_var_name
read -p "Enter the value of the environment variable (e.g. /usr/local/bin/python3.9): " env_var_value

# Set environment variable in bashrc file
echo "export $env_var_name=$env_var_value" >> ~/.bashrc

# Load the new environment variable into the current shell
source ~/.bashrc

# Verify that the environment variable was set correctly
echo "The $env_var_name environment variable is set to $env_var_value"
