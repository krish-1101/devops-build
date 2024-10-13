#!/bin/bash

# Variables
IMAGE_NAME="my-react-app"   # Name of your Docker image
IMAGE_TAG="latest"          # Tag of the image to deploy
CONTAINER_NAME="devops-build-web-1" # Name of the Docker container
PORT="90"                   # The port on which the app will run

# Stop and remove any running containers with the same name
echo "Stopping any running containers named $CONTAINER_NAME ..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Run the new container
echo "Deploying $IMAGE_NAME:$IMAGE_TAG as $CONTAINER_NAME ..."
docker run -d --name $CONTAINER_NAME -p $PORT:$PORT $IMAGE_NAME:$IMAGE_TAG

# Check if the deployment was successful
if [ $? -eq 0 ]; then
    echo "Container $CONTAINER_NAME deployed successfully."
else
    echo "Error: Deployment failed."
    exit 1
fi
