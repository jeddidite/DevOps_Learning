# Docker Basics and Commands
docker --version
docker version # Displays the Docker version information
docker info # Displays system-wide information about Docker
docker pull hello-world # Pulls the hello-world image from Docker Hub
docker run hello-world # Runs the hello-world container
docker images # Lists all images on the local machine
docker ps # Lists all running containers

# DockerHub website
# https://hub.docker.com/
docker login -u jeddidite # Log in to Docker Hub

# Clone New Docker project, build it, and run it
git clone https://github.com/docker/welcome-to-docker
cd welcome-to-docker
docker build -t welcome-to-docker .

# Turning an application into a Docker image
mkdir docker-hello-world
cd docker-hello-world
touch Dockerfile
touch index.html
cd .\docker-hello-world\ 
docker build -t hello-world-app .
docker run -p 8080:80 hello-world-app
# http://localhost:8080

# Runner the docker I just made on another machine: 
# On any server, anywhere in the world
docker pull jeddidite/devops_learning_app:latest
docker run -d -p 80:80 jeddidite/devops_learning_app:latest

#Stopping a container
docker ps
docker stop <container_id> # Stops a running container

# Running bind mounts: 
# BInd mounts let you mount a local file to your virtual environment. In this case, index.html gets mounted to 
# the root folder of the alpine nginx server so that any changes you make locally will be reflected in the container.
# This is useful for development and testing purposes.
# The -v flag is used to specify the volume to mount.
# The format for the -v flag is: -v <host_path>:<container_path>

# Single file mount 
docker run -p 8080:80 -v ${PWD}/index.html:/usr/share/nginx/html/index.html nginx:alpine  

# Mount the entire current directory
docker run -p 8080:80 -v ${PWD}:/usr/share/nginx/html nginx:alpine

# Using the full path (if the ${PWD} doesn't work)
docker run -p 8080:80 -v "C:\Users\Quacky\Desktop\Coding\DevOps Learning\DevOps_Learning\docker-hello-world":/usr/share/nginx/html nginx:alpine