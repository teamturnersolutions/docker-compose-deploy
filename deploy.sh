#!/bin/bash

set -e

# Print message
echo "Starting the deployment process..."

# Create directories
BASE_DIR="$HOME/docker-deploy"
mkdir -p "${BASE_DIR}"
cd "${BASE_DIR}"

# Clone repository
if [ ! -d "./docker-compose-deploy" ]; then
    echo "Cloning repository..."
    git clone https://github.com/teamturnersolutions/docker-compose-deploy.git
else
    echo "Repository already exists. Pulling latest changes..."
    cd docker-compose-deploy
    git pull
    cd ..
fi

# Set up Docker Compose files
cd docker-compose-deploy
for SERVICE in homeassistant pihole; do
    echo "Deploying $SERVICE..."
    cd $SERVICE
    docker-compose up -d
    cd ..
done

echo "Deployment complete!"

