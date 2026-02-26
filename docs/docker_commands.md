# Docker Commands Reference Guide

This document provides commonly used Docker commands for building, running, managing, and pushing container images.
# Docker Installation Check
```bash
docker --version
docker info
```
# Docker Image Commands
```bash
docker build -t image-name:tag .          # Build Image
docker images                             # List Images
docker rmi image-name:tag                 # Remove Image
docker rmi $(docker images -q -a) --force # Remove all images
```
# Docker Container Commands
```bash
# Run Container
docker run -d -p 5000:5000 --name container-name image-name:tag
```
## List Running Containers
```bash
docker ps                 # List Running Containers
docker ps -a              # List All Containers
```
## Container

```bash
docker stop container-name        # Stop Container
docker stop $(docker ps -q -a)    # Stop all Container
docker start container-name       # Start Container
docker rm container-name          # Remove Container
docker rm $(docker ps -q -a)      # Remove all Container

```
# Docker Logs and Exec
```bash
docker logs container-name                # View Logs
docker logs -f container-name             # Follow Logs
# Execute Command Inside Container
docker exec -it container-name /bin/bash
```
# Docker Tag and Push
```bash
docker tag image-name:tag repository-url:tag  # Tag Image
docker push repository-url:tag                # Push Image
docker pull repository-url:tag                # Pull Image
```
# Docker Network Commands
```bash
docker network ls                     # List Networks
docker network create network-name    # Create Network
```
# Docker Volume Commands
```bash
docker volume ls                      # List Volumes
docker volume create volume-name      # Create Volume
```
# Docker System Cleanup
## Remove Unused Containers, Images, Networks
```bash
# Remove Unused Containers, Images, Networks
docker system prune
# Remove Everything (Including Volumes)
docker system prune -a --volumes
```
# Push Docker Image to AWS ECR
## Set AWS Profile
```bash
export AWS_PROFILE=personal
```
## Authenticate and push Docker to ECR
```bash
aws ecr get-login-password --region eu-central-1 | \
docker login --username AWS --password-stdin <account_id>.dkr.ecr.eu-central-1.amazonaws.com
# Build Image Directly with ECR Tag
docker build -t <account_id>.dkr.ecr.eu-central-1.amazonaws.com/toolkit-managed-repository:latest .
# Push Image to ECR
docker push <account_id>.dkr.ecr.eu-central-1.amazonaws.com/toolkit-managed-repository:latest
# Verify Image in ECR
aws ecr describe-images \
  --repository-name toolkit-managed-repository \
  --region eu-central-1
```