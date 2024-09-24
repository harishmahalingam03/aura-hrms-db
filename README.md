# Pipeline for Create, build and deploy Postgres image on the DB instance 

https://us-east-1.console.aws.amazon.com/codesuite/codepipeline/pipelines/aura-db-hrms/view?region=us-east-1

for our pipeline we have 3 stages : For code build buildspec.yml and for deploy appspec.yml we need to have these available inside the DB repository
~~~
  Stage - 1 

      Source code
      
  Stage - 2 

      Build stage

  Stage - 3

      Deploy stage
~~~~

# Ensure that the Code Deploy is not in our deployment machine (Webapp /DB app) 
~~~~
sudo systemctl start codedeploy-agent
~~~~

# Optional:  if code-Deploy agent is not installed on your machine below command to install code deploy agent

~~~~
sudo apt update -y
sudo apt install -y ruby wget
cd /home/ubuntu
wget https://s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
~~~~

# Set Up Your CodePipeline

Create a CodePipeline:
  Navigate to the CodePipeline console and create a new pipeline.

# Source Stage:
  Choose your source provider (e.g., GitHub, CodeCommit) and link your repository.

  ![image](https://github.com/user-attachments/assets/3c818671-1c72-4806-b3f0-e0946091a986)

# Create the IAM role for Code Deploy with following policies:

![image](https://github.com/user-attachments/assets/10be4819-2567-4077-acbd-a29993c0be64)

# Create CodeDeploy Application and Deployment Group

    Create a CodeDeploy Application in the CodeDeploy console.
    Create a Deployment Group and link it to your EC2 instance using tags or instance ID.

![image](https://github.com/user-attachments/assets/a79c5608-8d8b-4062-b042-e4f153455746)

# Add Deploy Stage:

In CodePipeline, add the build and deploy stage with required configuration

![image](https://github.com/user-attachments/assets/5f3eb05a-afe4-4734-b723-268f38e1f9bb)

# Review all the configurations and create and run the pipeline. 

![image](https://github.com/user-attachments/assets/bb535f08-faf4-474f-93c3-fc245051bf29)



























