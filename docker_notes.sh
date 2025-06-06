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
docker build -t hello-world-app .
docker run -p 8080:80 hello-world-app
# http://localhost:8080

# Runner the docker I just made on another machine: 
# On any server, anywhere in the world
docker pull jeddidite/devops_learning_app:latest
docker run -d -p 80:80 jeddidite/devops_learning_app:latest

# Docker Volumes:
docker volume create db # Create a volume named 'db'
docker run -v db:/app/data nginx # Run an nginx container with the 'db' volume mounted
docker run -d -v db:/app/data nginx # Run in detached mode
docker volume ls # List all volumes
docker volume inspect db # Inspect the 'db' volume