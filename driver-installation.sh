#!/bin/bash

# Stop the script if any command fails
set -e

echo "Installing required Linux headers..."
sudo apt-get update
sudo apt-get install -y linux-headers-$(uname -r)

# Set distribution and architecture
DISTRO="ubuntu2204"
ARCH="x86_64"

echo "Downloading and installing CUDA keyring..."
wget https://developer.download.nvidia.com/compute/cuda/repos/$DISTRO/$ARCH/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update

echo "Installing NVIDIA driver..."
sudo apt-get install -y nvidia-open
sudo apt-get install -y cuda-drivers

echo "Rebooting system to complete installation..."
sudo reboot
