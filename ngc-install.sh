#!/bin/bash

# Download NGC CLI zip file
wget --content-disposition https://api.ngc.nvidia.com/v2/resources/nvidia/ngc-apps/ngc_cli/versions/3.59.0/files/ngccli_linux.zip -O ngccli_linux.zip

# Unzip the downloaded file
unzip ngccli_linux.zip

# Verify the file's integrity (MD5 hash check)
echo "Verifying MD5 checksum..."
find ngc-cli/ -type f -exec md5sum {} + | LC_ALL=C sort | md5sum -c ngc-cli.md5

# Verify the SHA256 hash (replace with actual SHA256 checksum)
echo "Verifying SHA256 checksum..."
sha256sum ngccli_linux.zip
echo "Expected SHA256: 87f03dab6d05e97547fb213ee4932654b3f6fccf82ca75f470d5cd3a4e8be8be"

# Make the NGC CLI binary executable
chmod u+x ngc-cli/ngc

# Add current directory to PATH (so that you can run ngc commands easily)
echo "export PATH=\"\$PATH:$(pwd)/ngc-cli\"" >> ~/.bash_profile
source ~/.bash_profile

# Configure the NGC CLI with your API key (you will be prompted to enter the API key)
ngc config set

echo "NGC CLI installation and configuration complete."
