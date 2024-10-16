#!/bin/bash
set -e

# Update package index and install docker.io
sudo apt-get update -y
sudo apt-get install unzip

# To install the AWS CLI, following commands added

#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#unzip awscliv2.zip
#sudo ./aws/install

sudo apt install docker.io

# Enable Docker service to start on boot
sudo systemctl enable docker
sudo systemctl start docker


# Log in to AWS ECR
TOKEN=$(aws ecr get-login-password --region us-east-1)
if [ -z "$TOKEN" ]; then
    echo "Failed to get ECR login token" >&2
    exit 1
fi
echo "$TOKEN" | sudo docker login --username AWS --password-stdin 270514764245.dkr.ecr.us-east-1.amazonaws.com

sudo rm -rf /home/ubuntu/aura-db || true

sudo docker rm -f aura-db || true 

sudo docker network rm aura-network || true

#sudo docker network rm -f aura-network || true

docker pull 270514764245.dkr.ecr.us-east-1.amazonaws.com/aura-postgres:latest

docker network create aura-network


# docker run -d --name aura-app --hostname localhost -e "AWS_ACCESS_KEY_ID=AKIAT567PXHK6WVKNEOS3" -e "AWS_SECRET_ACCESS_KEY=9yZfLNgfLmMtIc+uERbDFw+jygll+MtjuX8rqWZKl" -e "OTP_API_KEY=5d7dbdd8-6498-11ef-8b60-0200cd936042" -p 80:80 -d 270514764245.dkr.ecr.us-east-1.amazonaws.com/static-website:latest
#docker run -d --name aura-db --hostname localhost -e "AWS_ACCESS_KEY_ID=AKIAT567PXHK6WVKNEOS3" -e "AWS_SECRET_ACCESS_KEY=9yZfLNgfLmMtIc+uERbDFw+jygll+MtjuX8rqWZKl" -e "OTP_API_KEY=5d7dbdd8-6498-11ef-8b60-0200cd936042" -p 5432:5432 -d 270514764245.dkr.ecr.us-east-1.amazonaws.com/aura-hrms-db:latest

docker run -d \
  --name aura-db \
  --network aura-network \
  --env POSTGRES_USER=postgres \
  --env POSTGRES_PASSWORD=password \
  --env POSTGRES_DB=hrms \
  --publish published=5432,target=5432 \
  270514764245.dkr.ecr.us-east-1.amazonaws.com/aura-postgres:latest
