# Makefile for managing CUDA pre-installation checks and installation

SHELL := /bin/bash
PREINSTALL_SCRIPT := pre-installation-verif.sh
INSTALL_SCRIPT := cuda-install.sh

.PHONY: all preinstall install verify clean

# Default target: Run pre-installation checks, then install and verify CUDA
all: preinstall install verify

# Step 1: Run pre-installation checks
preinstall: $(PREINSTALL_SCRIPT)
	@echo "Running pre-installation checks..."
	chmod +x $(PREINSTALL_SCRIPT)
	sudo ./$(PREINSTALL_SCRIPT)

# Step 2: Install CUDA by running the installation script
install: $(INSTALL_SCRIPT)
	@echo "Running CUDA installation script..."
	chmod +x $(INSTALL_SCRIPT)
	sudo ./$(INSTALL_SCRIPT)

# Step 3: Verify CUDA installation
verify:
	@echo "Verifying CUDA installation..."
	@nvcc --version && nvidia-smi

# Clean up downloaded files
clean:
	@echo "Cleaning up CUDA installation files..."
	rm -f cuda-ubuntu2204.pin cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb
