#!/bin/bash

# Uninstall old versions if any
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  sudo apt-get remove -y $pkg
done

# Set up the Docker repository

# Update and install necessary packages
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# Install Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt sources
sudo apt-get update

# Install Docker Engine and other dependencies
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Optional: Change the default docker0 bridge IP if needed
echo '{"bip": "192.168.5.1/24"}' | sudo tee /etc/docker/daemon.json

# Restart Docker service to apply changes
sudo systemctl restart docker

# Verify the installation and check the docker0 bridge IP
ifconfig
