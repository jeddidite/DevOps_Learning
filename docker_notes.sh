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
# But if you want to control the name of the container, instead of it generating a random name, you can use the --name flag:
docker run -d --name devops_container -p 80:80 jeddidite/devops_learning_app:latest

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
# Docker Volumes:
docker volume create db # Create a volume named 'db'
docker run -v db:/app/data nginx # Run an nginx container with the 'db' volume mounted
docker run -d -v db:/app/data nginx # Run in detached mode
docker volume ls # List all volumes
docker volume inspect db # Inspect the 'db' volume

# Docker Networks:
#Bridge vs host vs none. 
#Bridge is the defualt network and it lets local containers talk to each other. 
#The host network allows local containers to talk to the outside world. 
#The none network isolates the container from all networks.

docker network ls # List all networks
docker network create devops_network # Create a new network named 'my-network'  
docker network inspect devops_network # Inspect the 'my-network' network
# Running a container on a specific network
docker run -d --name test_container_1 --network devops_network nginx # Run an nginx container on 'my-network'
docker run -d --name test_container_2 --network devops_network nginx # Run an nginx container on 'my-network'

# Testing network connectivity between containers
docker exec -it test_container_1 curl http://test_container_2 # Curl 'test_container_2' from 'test_container_1'
docker exec -it test_container_2 curl http://test_container_1 # Curl 'test_container_1' from 'test_container_2'

docker exec -it test_container_1 apt-get update    # Update package lists in 'test_container_1'
docker exec -it test_container_1 apt-get install -y iputils-ping # Install ping in 'test_container_1'
docker exec -it test_container_2 apt-get update # Update package lists in 'test_container_2'
docker exec -it test_container_2 apt-get install -y iputils-ping # Install ping in 'test_container_2'

# Testing network connectivity between containers using ping
docker exec -it test_container_1 ping test_container_2 # Ping 'test_container_2' from 'test_container_1'
docker exec -it test_container_2 ping test_container_1 # Ping 'test_container_1' from 'test_container_2'

# Testing network connectivity from a container to the host
docker exec -it test_container_1 ping host.docker.internal # Ping the host from 'test_container_1' (works on Docker Desktop)
docker exec -it test_container_2 ping host.docker.internal # Ping the host from 'test_container_2' (works on Docker Desktop)

# Testing network connectivity from a container to the internet
docker exec -it test_container_1 ping google.com # Ping google.com from 'test_container_1'
docker exec -it test_container_2 ping google.com # Ping google.com from 'test_container_2'

# Testing network connectivity from the host to a container
docker exec -it devops_container ping test_container_1 # Ping 'test_container_1' from the host
docker exec -it devops_container ping test_container_2 # Ping 'test_container_2' from the host

# Running a container with a specific network alias 
docker run -d --name devops_container --network devops_network --network-alias devops_network nginx # Run an nginx container with alias 'my-nginx' on 'my-network'
# Connecting an existing container to a network
docker network connect devops_network devops_container # Connect 'my-nginx' to 'my-network'
# Disconnecting a container from a network
docker network disconnect devops_network devops_container # Disconnect 'my-nginx' from 'my-network'
