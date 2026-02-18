# DevOps Toolkit
A Docker-based development environment for working with:
- AWS CLI
- Terraform
- kubectl
- Helm
- Infrastructure as Code workflows

This container provides a consistent, isolated DevOps environment without installing tools directly on your host machine.

# Prerequisites
- Docker
- Docker Compose
- SSH configured (if accessing private GitHub repositories)
- AWS account access

# Create Environment File
Create a .env file at devops-toolkit/build/.env.local directory:
```
touch devops-toolkit/build/.env.local
```

Example .env:
```
ENV=devops
AWS_ACCOUNT_ID=xxxxxxxxxxxx
AWS_DEFAULT_REGION=eu-central-1
AWS_ASSUME_ROLE_ARN=arn:aws:iam::xxxxxxxxxxxx:role/SuperDevRole
TF_TOKEN=
```
# Create you docker compose file
 Keep this out of the folder, you can keep inside also by changing the path accordingly
```
version: "3.9"
services:
  # DevOps Toolkit Service
  devops-toolkit:
    container_name: devops-toolkit
    build:
      context: ./devops-toolkit
      dockerfile: build/Dockerfile
      args:
        FOLDER: devops
    env_file:
      - ./devops-toolkit/build/.env.local
    command: tail -F /dev/null
    stdin_open: true
    tty: true
    volumes:
      - ./devops-toolkit:/devops
      - ./devops-toolkit/build/.devops_bash_history:/root/.bash_history
      # Optional (Recommended for AWS usage)
      # - ~/.aws:/root/.aws:ro
      # - ~/.ssh:/root/.ssh:ro
    networks:
      - backend

networks:
  backend:
    driver: bridge
```
# How to Use
Build:
```
docker compose build
```

Start:
```
docker compose up -d
```

Enter container:
```
docker exec -it devops-toolkit bash
```

Stop:
```
docker compose down
```