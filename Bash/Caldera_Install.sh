#!/bin/bash

# Define a bright orange color
ORANGE='\033[1;33m'
NC='\033[0m' # No Color (reset color)

# Macro-style function to print messages
print_message() {
  echo -e "${ORANGE}>>> $1 <<<${NC}"
}

# Update package list
print_message "Updating package list"
sudo apt update

# Install Git
print_message "Installing Git"
sudo apt install -y git

# Install curl
print_message "Installing curl"
sudo apt install -y curl

# Install Python3 pip
print_message "Installing Python3 pip"
sudo apt install -y python3-pip

# Install Go programming language (version 1.19)
print_message "Installing Go 1.19"
wget https://golang.org/dl/go1.19.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
rm go1.19.linux-amd64.tar.gz
go version

# Remove existing npm and nodejs
print_message "Removing existing npm and nodejs"
sudo apt remove --purge -y npm nodejs

# Autoremove and autoclean to clean up the system
print_message "Running autoremove and autoclean"
sudo apt autoremove -y
sudo apt autoclean

# Remove npm directories from user folder
print_message "Removing npm directories from user folder"
sudo rm -rf ~/.npm

# Add Node.js 16 repository and install Node.js 16
print_message "Installing Node.js version 16"
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify Node.js and npm versions
print_message "Verifying Node.js and npm installation"
node -v
npm -v

# Clone the Caldera repository
print_message "Cloning Caldera repository"
git clone https://github.com/mitre/caldera.git --recursive

# Change directory into Caldera folder
print_message "Changing to Caldera directory"
cd caldera

# Install Python dependencies using pip
print_message "Installing Python dependencies"
pip3 install -r requirements.txt

# Build and start the Caldera server
print_message "Building and starting Caldera server"
python3 server.py --build &
