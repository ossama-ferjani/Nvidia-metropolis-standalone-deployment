#!/bin/bash

# Stop execution if any command fails
set -e

echo "Starting CUDA 12.8 installation on Ubuntu 22.04..."

# Step 1: Remove previous CUDA and NVIDIA drivers if any
echo "Removing any existing CUDA and NVIDIA packages..."
sudo apt-get --purge remove '*cuda*' '*nvidia*' -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y

# Step 2: Add the CUDA repository
echo "Adding CUDA repository..."
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600

# Step 3: Download and install CUDA 12.8 repository package
echo "Downloading and installing CUDA 12.8 repository package..."
wget https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb

# Step 4: Copy keyring and update package list
echo "Updating package list..."
sudo cp /var/cuda-repo-ubuntu2204-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update

# Step 5: Install CUDA Toolkit
echo "Installing CUDA Toolkit 12.8..."
sudo apt-get -y install cuda-toolkit-12-8

# Step 6: Set environment variables
echo "Setting up environment variables..."
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

# Step 7: Verify Installation
echo "Verifying CUDA installation..."
nvcc --version
nvidia-smi

echo "CUDA 12.8 installation completed successfully!"
