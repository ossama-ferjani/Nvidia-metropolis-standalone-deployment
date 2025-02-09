#!/bin/bash

# Function to check if a package is installed
dependency_check() {
    dpkg -l | grep -q "$1" && echo "$1 is already installed." || {
        echo "$1 is not installed. Installing..."
        sudo apt update && sudo apt install -y "$1"
    }
}

# 2.1 Verify You Have a CUDA-Capable GPU
echo "Checking for CUDA-capable GPU..."
lspci | grep -i nvidia || {
    echo "No NVIDIA GPU detected. Updating PCI hardware database..."
    sudo update-pciids
    lspci | grep -i nvidia || {
        echo "No NVIDIA GPU found after update. Exiting."
        exit 1
    }
}
echo "NVIDIA GPU detected. Check CUDA compatibility at: https://developer.nvidia.com/cuda-gpus"

# 2.2 Verify You Have a Supported Version of Linux
echo "Checking Linux distribution and version..."
uname -m && cat /etc/*release

# 2.3 Verify the System Has gcc Installed
echo "Checking for gcc installation..."
gcc --version || {
    echo "gcc not found. Installing..."
    sudo apt update && sudo apt install -y gcc
}

echo "All necessary components verified or installed successfully!"
