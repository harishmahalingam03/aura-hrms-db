#!/bin/bash
set -e

# Update package index and install docker.io
sudo apt-get update -y
sudo apt-get install docker.io -y
sudo apt-get install unzip

# To install the AWS CLI, following commands added

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install



# Enable Docker service to start on boot
sudo systemctl start docker
sudo systemctl enable docker
   
# Log in to AWS ECR
TOKEN=$(aws ecr get-login-password --region us-east-1)
if [ -z "$TOKEN" ]; then
    echo "Failed to get ECR login token" >&2
    exit 1
fi
echo "$TOKEN" | sudo docker login --username AWS --password-stdin 270514764245.dkr.ecr.us-east-1.amazonaws.com


docker pull 270514764245.dkr.ecr.us-east-1.amazonaws.com/static-website:latest

# docker network create aura-network


# docker run -d --name aura-app --hostname localhost -e "AWS_ACCESS_KEY_ID=AKIAT567PXHK6WVKNEOS3" -e "AWS_SECRET_ACCESS_KEY=9yZfLNgfLmMtIc+uERbDFw+jygll+MtjuX8rqWZKl" -e "OTP_API_KEY=5d7dbdd8-6498-11ef-8b60-0200cd936042" -p 80:80 -d 270514764245.dkr.ecr.us-east-1.amazonaws.com/static-website:latest
docker run -d --name aura-app --hostname localhost -e "AWS_ACCESS_KEY_ID=AKIAT567PXHK6WVKNEOS3" -e "AWS_SECRET_ACCESS_KEY=9yZfLNgfLmMtIc+uERbDFw+jygll+MtjuX8rqWZKl" -e "OTP_API_KEY=5d7dbdd8-6498-11ef-8b60-0200cd936042" -p 80:80 -d 270514764245.dkr.ecr.us-east-1.amazonaws.com/static-website:latest
