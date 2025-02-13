#!/bin/bash

# Setup the repository and the GPG key
distribution=$(. /etc/os-release; echo $ID$VERSION_ID) \
  && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
       sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
       sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Update the package list
sudo apt-get update

# Install the NVIDIA container toolkit package
sudo apt-get install -y nvidia-container-toolkit

# Configure Docker to use the NVIDIA Container Runtime
sudo nvidia-ctk runtime configure --runtime=docker

# Restart the Docker daemon
sudo systemctl restart docker

# Verify the installation (ensure Docker is configured for non-sudo usage)
docker run --rm --gpus all nvidia/cuda:12.2.0-base-ubuntu20.04 nvidia-smi
