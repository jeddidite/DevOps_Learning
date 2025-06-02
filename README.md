# DevOps_Learning
Documentation of all the technologies being studied for DevOps

# Docker CI/CD Pipeline Setup Guide

**Transforms this:**
```bash
# Manual, local-only development
docker build -t my-app .
docker run -p 8080:80 my-app
# "It works on my machine" syndrome
```

**Into this:**
```bash
# Automated, global deployment
git push origin main
# → GitHub Actions auto-builds Docker image
# → Pushes to Docker Hub
# → Anyone, anywhere can run: docker pull yourusername/your-app
```

**Benefits:**
- ✅ **Zero manual builds** - Push code, get deployed container
- ✅ **Global sharing** - Anyone can run your exact app with one command
- ✅ **Version control** - Every commit = tagged Docker image
- ✅ **Production ready** - Same process Netflix/Uber/Spotify use
- ✅ **Team collaboration** - Identical environments for everyone
- ✅ **Easy scaling** - Deploy to AWS/Azure/Google Cloud instantly

---

## Complete Setup Commands

### 1. Docker Hub Setup
```bash
# Go to https://hub.docker.com
# Create account
# Create repository (e.g., "my-app")
# Go to Account Settings → Security → New Access Token
# Name: "GitHub Actions"
# Permissions: Read, Write, Delete
# Copy the token (save it!)
```

### 2. Project Structure
```bash
# Create project directory
mkdir docker-project
cd docker-project

# Create required directories
mkdir .github
mkdir .github/workflows
mkdir docker-hello-world

# Your project structure should look like:
# docker-project/
# ├── .github/
# │   └── workflows/
# │       └── docker-build.yml
# ├── docker-hello-world/
# │   ├── Dockerfile
# │   └── index.html
# └── (other files...)
```

### 3. Create Docker Files

**Create `docker-hello-world/Dockerfile`:**
```dockerfile
# Use the official nginx image as base image
FROM nginx:alpine

# Copy our HTML file to nginx's default document root
COPY index.html /usr/share/nginx/html/

# Expose port 80 to allow external access
EXPOSE 80

# nginx starts automatically with the default CMD, so no need to specify one
```

**Create `docker-hello-world/index.html`:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello Docker World</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            text-align: center;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        p {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }
        .docker-logo {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="docker-logo">🐳</div>
        <h1>Hello, Docker World!</h1>
        <p>Your containerized application is running successfully!</p>
        <p>🎉 Congratulations on your first Docker container! 🎉</p>
    </div>
</body>
</html>
```

### 4. GitHub Actions Workflow

**Create `.github/workflows/docker-build.yml`:**
```yaml
name: Build and Push Docker Image

on:
  push:
    branches: [ main ]
    paths:
      - 'docker-hello-world/**'
  pull_request:
    branches: [ main ]
    paths:
      - 'docker-hello-world/**'

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v3
      
    - name: Login to Docker Hub
      uses: docker/login-action@v3
      with:
        username: ${{ secrets.DOCKERHUB_USERNAME }}
        password: ${{ secrets.DOCKERHUB_TOKEN }}
        
    - name: Build and push Docker image
      uses: docker/build-push-action@v5
      with:
        context: ./docker-hello-world
        push: true
        tags: |
          ${{ secrets.DOCKERHUB_USERNAME }}/YOUR_REPO_NAME:latest
          ${{ secrets.DOCKERHUB_USERNAME }}/YOUR_REPO_NAME:${{ github.sha }}
        platforms: linux/amd64,linux/arm64
```

**⚠️ Replace `YOUR_REPO_NAME` with your actual Docker Hub repository name!**

### 5. GitHub Repository Secrets

```bash
# Go to your GitHub repository
# Settings → Secrets and variables → Actions
# Add Repository Secrets:

# Secret 1:
# Name: DOCKERHUB_USERNAME
# Secret: your-docker-hub-username

# Secret 2:
# Name: DOCKERHUB_TOKEN
# Secret: paste-your-access-token-here
```

### 6. Deploy and Test

```bash
# Initialize git (if not already done)
git init
git remote add origin https://github.com/yourusername/your-repo.git

# Add all files
git add .
git commit -m "Add Docker CI/CD pipeline"
git push origin main

# Check GitHub Actions (should start automatically)
# Go to: https://github.com/yourusername/your-repo/actions

# Once workflow completes, test your image
docker pull yourusername/your-repo-name:latest
docker run -p 8080:80 yourusername/your-repo-name:latest

# Open browser to: http://localhost:8080
```

### 7. Verification Commands

```bash
# Check if image exists on Docker Hub
docker search yourusername/your-repo-name

# Pull and run your image
docker pull yourusername/your-repo-name:latest
docker run -d -p 8080:80 yourusername/your-repo-name:latest

# Check running containers
docker ps

# Stop container
docker stop <container-id>

# Remove container
docker rm <container-id>

# Remove image
docker rmi yourusername/your-repo-name:latest
```

---

## Quick Reference for Future Projects

### For New Projects:
1. Create Docker Hub repository
2. Copy `.github/workflows/docker-build.yml` (update repo name)
3. Create your `Dockerfile` and app files
4. Set GitHub secrets (if new repo)
5. `git push origin main`
6. ✅ Auto-deployed!

### Common Issues:
- **Workflow not running**: Check file is at `.github/workflows/` (not inside project folder)
- **Push failed**: Verify Docker Hub secrets are correct
- **Image not found**: Wait for workflow to complete (green checkmark)
- **Port already in use**: Use different port: `-p 8081:80`

### Best Practices:
- Use specific tags for production: `v1.0.0` instead of `latest`
- Test locally first: `docker build -t test .`
- Check logs: `docker logs <container-id>`
- Use multi-stage builds for smaller images
- Always use `.dockerignore` to exclude unnecessary files
