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



# Docker installation and setup
# Create the docker group
sudo groupadd docker

# Add your user to the docker group
sudo usermod -aG docker $USER

# Inform the user to log out and log back in
echo "You need to log out and log back in for the group membership to take effect."

# If running in a virtual machine, recommend restarting
echo "If you're running Linux in a virtual machine, it may be necessary to restart the VM for changes to take effect."

# Alternatively, activate the changes to groups without logout
echo "You can also run 'newgrp docker' to activate changes to your group immediately."
