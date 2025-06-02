# Docker Basics and Commands
docker --version
docker version # Displays the Docker version information
docker info # Displays system-wide information about Docker
docker pull hello-world # Pulls the hello-world image from Docker Hub
docker run hello-world # Runs the hello-world container
docker images # Lists all images on the local machine
docker ps # Lists all running containers

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