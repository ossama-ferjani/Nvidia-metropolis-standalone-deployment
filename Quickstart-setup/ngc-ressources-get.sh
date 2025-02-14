#!/bin/bash

# Define the resource path from NGC
RESOURCE_PATH="nfgnkvuikvjm/mdx-v2-0/metropolis-apps-standalone-deployment:v2.1-06132024"

# Download the folder using NGC CLI
echo "Downloading Metropolis Apps Deployment..."
ngc registry resource download-version "$RESOURCE_PATH"

# Extract the downloaded folder name
TAR_FILE="metropolis-apps-standalone-deployment.tar.gz"
FOLDER_NAME="metropolis-apps-standalone-deployment"

# Check if the file exists before extracting
if [ -f "$TAR_FILE" ]; then
    echo "Extracting $TAR_FILE..."
    tar xvf "$TAR_FILE"
else
    echo "Error: $TAR_FILE not found!"
    exit 1
fi

# Navigate to the deployment directory
cd "$FOLDER_NAME" || { echo "Failed to enter directory $FOLDER_NAME"; exit 1; }

# Start the deployment using Docker Compose
echo "Starting Docker Compose..."
docker-compose up -d

echo "Deployment started successfully!"
