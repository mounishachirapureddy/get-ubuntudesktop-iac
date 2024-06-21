
# Automating Infrastructure and Software Configuration with Terraform, Ansible, Jenkins, and Docker

This project aims to automate the provisioning and configuration of infrastructure and software for setting up a remote desktop environment using Terraform, Ansible, Jenkins, and Docker.



## **The process involves the following Key Steps:**

1. **Provision Jenkins Server**: Create the necessary infrastructure on the Google Cloud Platform (GCP) using Terraform. This includes a Virtual Private Cloud (VPC), a Service Account, and a Virtual Machine (VM) instance configured as a Jenkins server.

2. **Provision Ubuntu Desktop Server**: Use another Terraform script to provision a VM instance running Ubuntu 20.04. This VM will connect to the previously created VPC and serve as a remote desktop environment.

3. **Configure Ubuntu Desktop Server**: Use an Ansible playbook to install necessary software on the Ubuntu Desktop server, including Python and Chrome Remote Desktop, and set up the desktop environment.

4. **Execute Configuration via Jenkins**: Configure the Jenkins server to run jobs using Docker agent nodes. These jobs will execute the Terraform scripts and the Ansible playbook to provision and configure the Ubuntu Desktop server.

5. **Access Remote Desktop**: Access the desktop environment on the Ubuntu Desktop VM instance remotely using Chrome Remote Desktop.

## Prerequisites

1. Base VM with “Git”, “Terraform”, “And Docker” Installed in it & “Service-account” with appropriate permission to create 
   Infrastructure.
2. Docker Hub Account.


## Workflow for “Base-VM”:

### Step 1: Create a VM instance with Ubuntu OS.

### Step 2: Connect to VM-instance SSH – Terminal and run the following commands.

```
    gcloud auth application-default login  
``` 
#### OR

```
    gcloud auth print-access-token

    export TOKEN="PASTE THE ABOVE GENERATED TOKEN HERE"
```
### Step 3: Install Git, Terraform, Docker.

```
    # Update packages
      sudo apt update

    # Git installation
      sudo apt install git -y

    # Terraform installation

     wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
     echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
     sudo apt update && sudo apt install terraform

    #Docker Installation

    sudo apt install docker.io -y
    sudo systemctl daemon-reload
    sudo systemctl restart docker

```
### Step 4: Clone Repo to local as “root user”: 
```
    • sudo su
    • git clone https://github.com/bpurnachander/get-ubuntudesktop-iac.git
```

### Step 5: Building image and pushing to Docker Hub.
```
      cd get-ubuntudesktop-iac

    # Build and push image to Docker Hub

      docker login

    # Provide Docker Hub credentials(username & password)

```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/271dc614-4bdb-4bc6-a303-e0d68cdee722)

```
docker build -t username/repo_name .
docker push username/repo_name
```
![image-1](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/8b05247d-2d1a-446c-97dd-5e45db547170)

![image-2](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/7179d505-96d3-4e77-aa84-2589725379db)

### Step 6: Creating Infrastructure using terraform.
```
    cd /root/get-ubuntudesktop-iac/terraform
    terraform init
    terraform plan
    terraform apply --auto-approve
```
> [!IMPORTANT] 
> Make sure to change necessary sections like **Project-ID**, **Backup-bucket-name** & **Source Path** in the **main.tf** file 
  with your details.

![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/1ecbd237-7c24-453a-a579-84d9c82bf95f)

>Make Sure to keep your pipeline name what you mentioned in /var/lib/jenkins/workspace/**Your-Pipeline-Name**
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/6dd6be29-bfe2-4439-b2f3-dcf4a250890a)


### Step 7: Connect to jenkins VM-instance SSH – Terminal & get Jenkins UI Password.
```
cat /var/lib/jenkins/secrets/initialAdminPassword
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/5d26fc07-9174-49e5-936e-f079b34843e5)


### Step 8: Connecting to “Jenkins-UI”.

>        Browse “Jenkins-server-Public-IP:8080” and paste above “password” here.
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/205ec6a1-1e81-4c41-b275-733bc16d25e4)

![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/b1a3a664-6026-49c6-9838-d47b27bcf02a)

![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/6eb511b8-ae20-4df3-b93d-16cc7c25e478)


# **Add new “Jenkins credentials”.**

![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/8ce47e5a-db61-411e-a679-d1774b137441)

![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/06e408d7-cc1f-4bee-952e-c74e54669549)

![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/d7dd72b1-87fe-44db-a977-50b78083f908)


### Step 9: Installing necessary plugins: 
            - Docker
            - Pipeline Stage View
```
        Dashboard--> Manage Jenkins--> Plugins --> Available plugins --> "search for plugins & Install"
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/fdca3581-6e02-4104-8c8f-17c7d6cd0e85)


### Step 10: Adding global credentials for:
            - Docker Hub.
            - Jenkins agent.
            - Service-account JSON key.
> Adding Docker Hub credentials.
```
Manage Jenkins -> credentials -> global -> add credentials -> kind (username &
password) -> username & password (docker-hub username & password) -> Id(docker-hub) 
-> save
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/62a9ce63-fe4a-4d87-bf81-e3a4133b926e)


>Adding Jenkins-agent credentials.
```
Manage Jenkins --> credentials -> global -> add credentials -> kind (username &
password) -> username (jenkins) -> password (password) -> Id (jenkins-user)-> save
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/78b57dfb-4e77-4203-8047-7671672ec7c9)

>Adding Service-account JSON key credentials
```
Manage Jenkins --> credentials -> global -> add credentials -> kind (Secret file) 
-> File(Choose file)--> ID(svc-json)-> save
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/86a3dee6-f96d-4d52-bf8a-4bb01d2f993a)

### Step 11: Create a new Pipeline job
```
Dashboard--> + New Item--> Enter an item name(desktop)--> Pipeline--> OK

NOTE: Kindly add your pipeline name as per the path of terraform code . 

source = "/var/lib/jenkins/workspace/Youre-pipeline-Name/terraform-folder-Namae/modules/desktop-server"
```
>E.g:
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/075ac101-e391-44ad-a9db-786a5bc7c0f2)
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/a0a85b50-4d41-41b6-bcb8-15c6ec235954)

### Step 12: Integrating Git for source code.
```
Pipeline-->Definition(Pipeline script from SCM)--> SCM(Git)--> Repositories
--> Repository URL(https://github.com/bpurnachander/get-ubuntudesktop-iac.git)
--> Branches to build--> Branch Specifier(*/main)-->Script Path(Jenkins)--> Save
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/617b64f1-0b15-4477-840d-8e693934fa3d)
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/78a75e86-a395-43ee-85ac-f130b8d35b48)

### Step 13: Adding parameters
```
This Project is Parameterized
--> Add Parameter
--> Choice Parameter--> Name(tfm_action)--> Choices(apply, destroy, ansible)
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/6ca7f240-3490-4174-b958-dc5f562193e1)
```
--> Add Parameter
--> Choice Parameter--> Name(ansible_action)--> Choices(---, apply, destroy)
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/888e1f21-7c47-4e3b-bdcb-2a5c08239ea4)
```
--> Add Parameter
--> Choice Parameter--> Name(target_hosts)--> Choices(---, desktop, apache2)
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/e00d8b25-7a5b-4dc0-8f05-1b7d1c67f969)

### Step 14: Configuring Docker as Jenkins-agent.
```
Dashboard--> Manage Jenkins--> Clouds--> New cloud--> Cloud name(docker)--> Type
--> Docker(select it)-->Create
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/e6e18f09-d3e0-4b93-a916-97cb212b0504)
```
	--> Docker Cloud details--> Docker Host URI--> tcp://Public-IP:4243--> Test Connection
	    Output will be like(Version = 24.0.5, API Version = 1.43)
	-->Enabled(click it)
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/8b5c13a2-9cf8-447b-b495-f6fe42a76fda)
```
    --> Docker Agent templates--> Add Docker Template--> Labels-->docker--> Enabled
    --> Name--> docker-agent--> Docker Image--> GIVE YOUR IMAGE
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/44190195-3986-4b8b-ac53-dc5f5aeb8fda)
```
	--> Registry Authentication(select Docker Hub credentials ID)
	--> Remote File System Root--> /var/lib/jenkins
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/71d45b50-23d6-43a5-a3de-a5def9047a4e)
```
	--> Usage--> Only build jobs with label expressions matching this node
	--> Connect method--> Connect with SSH--> SSH key--> use configured SSH credentials
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/33d93291-3e36-4586-835a-05994100fbed)
```
	--> SSH Credentials--> SSH Credentials(select jenkins-agent credentials ID)
	-->Host Key Verification Strategy-->Non verifying strategy-->save.
```
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/293b5cf0-0270-4c29-a55a-8ddd894466b5)

### Step 15: Build your pipeline with appropriate choices.
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/28ae5d25-1a3c-43c3-bd28-cf9831f7c1c2)
![image](https://github.com/bpurnachander/get-ubuntudesktop-iac/assets/60452355/69e1d68a-0c1f-4e2d-93c6-86801e148eee)


## If you found this repo useful, give it a STAR 🌠
