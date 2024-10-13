#!/bin/bash

# Variables
IMAGE_NAME="my-react-app"   # Name of your Docker image
IMAGE_TAG="latest"          # Tag for the image, you can modify it to include version or timestamp

# Build the Docker image
echo "Building Docker image: $IMAGE_NAME:$IMAGE_TAG ..."
docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Docker image $IMAGE_NAME:$IMAGE_TAG built successfully."
else
    echo "Error: Docker image build failed."
    exit 1
fi
