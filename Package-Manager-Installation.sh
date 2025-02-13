
#!/bin/bash

# Stop the script on errors
set -e

echo "Removing outdated NVIDIA signing key..."
sudo apt-key del 7fa2af80 || echo "Key not found, skipping..."

echo "Downloading and installing the new CUDA keyring..."
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb

echo "Updating package lists..."
sudo apt-get update

echo "Installing CUDA Toolkit..."
sudo apt-get install -y cuda-toolkit

echo "Installing NVIDIA GDS (GPUDirect Storage)..."
sudo apt-get install -y nvidia-gds

echo "Rebooting the system to complete installation..."
sudo reboot