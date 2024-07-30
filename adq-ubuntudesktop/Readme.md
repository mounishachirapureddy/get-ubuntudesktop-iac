Click here for complete [Documentation](https://fortunate-headlight-ff9.notion.site/ADQ-UBUNTUDESKTOP-IAC-8caceafdf6f14875810396b9a136a86e)


# Automating Infrastructure and Software Configuration with Terraform, Ansible, Jenkins, and Docker

  ![image](https://github.com/user-attachments/assets/17a77772-15ea-4504-b4de-30d6800389b4)

This project aims to automate the provisioning and configuration of infrastructure and software for setting up a remote desktop environment using Terraform, Ansible, Jenkins, and Docker.

### Create 3 Projects
1. My First Project 
2. gcp-adq-pocproject-dev
3. gcp-adq-pocproject-prod


## Prerequisites

1. Base VM with “Git”, “Terraform”, “And Docker” Installed in it & “Service-account” with appropriate 
   permission to create Infrastructure.

2. Docker Hub Account.

3. Three GCP Projects with common Service Account. 

5. GCP Buckets  



## Service Account Setup: 

### Step-1 
```
 Go to My First Project (melodic-agency-427111-k1) 
 Create a Service Account with **Owner** Permission.
```
### Step-2
```
Now Go to "gcp-adq-pocproject-dev" 
Add base project (My-First-Project) service account Email as principal in project "gcp-adq-pocproject-dev".
Add Role Owner Permission.
```
### Step-3
```
Now Go to "gcp-adq-pocproject-prod"
Add base project service (My-First-Project) account Email as principal in project  "gcp-adq-pocproject-prod".
Add Role Owner Permission.
```
## Workflow for “Base-VM”:

### Step 1: Create a VM instance with Ubuntu OS.

Create a VM with Ubuntu os in base project (My-First-Project) with service account created .

### Step 2: Install Git, Terraform, Docker.

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
### Step 3: Clone Repo to local as “root user”: 
```
    • sudo su
    • git clone https://github.com/bpurnachander/get-ubuntudesktop-iac.git
```

### Step 4: Provisioning Networking and the service account
We have to create networking services like subnet and firewall.

```
	cd /root/get-ubuntudesktop-iac/terraform/environments/dev
	
	terraform init
	terraform plan --var-file=terraform.tfvars
	terraform apply --auto-approve --var-file=terraform.tfvars
```
### Code Structure

```
pwd //path
/root/dinesh/get-ubuntudesktop-iac/terraform/environments/dev

terraform/
├── environments
│   ├── dev
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── prod
│       ├── backend.tf
│       ├── main.tf
│       ├── terraform.tfvars
│       └── variables.tf
└── modules
    ├── networking
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── service-account
        ├── main.tf
        ├── outputs.tf
        └── variables.tf
```
### Step 5: Provisioning Jenkins server
We have to create a jenkins server i.e adq-jenkins-box.

```
cd /root/get-ubuntudesktop-iac/adq-jenkins-box
terraform init
terraform plan --var-file=terraform.tfvars
terraform apply --auto-approve --var-file=terraform.tfvars
```
### Code structure
```
pwd
/root/get-ubuntudesktop-iac/adq-jenkins-box

adq-jenkins-box/
├── adq-get-java-app
│   └── Jenkinsfile
├── main.tf
├── modules
│   └── adq-jenkins-box
│       ├── main.tf
│       └── variables.tf
├── terraform.tfvars
└── variables.tf
```

### Step 6: Connecting to “Jenkins-UI”
Now login to Jenkins server and login
```
cat /var/lib/jenkins/secrets/initialAdminPassword
```
 Browse “Jenkins-server-Public-IP:8080” and paste above “password” here.


### Step 7: Configuring docker and git hub
Building image and pushing to Docker Hub registory.

```
      cd get-ubuntudesktop-iac

    # Build and push image to Docker Hub

      docker login

    # Provide Docker Hub credentials(username & password)

docker build -t username/repo_name .
docker push username/repo_name
```

### Step 8: Make sure to change necessary sections
> [!IMPORTANT] 
> Make sure to change necessary sections like **Project-ID**, **Backup-bucket-name** & **Source Path** in the **main.tf** file with your details.

> [!IMPORTANT]
Modification Required
```
>Make Sure to change in terraform.tfvars

>In path "get-ubuntudesktop-iac/adq-jenkins-box/terraform.tfvars"
>In path "get-ubuntudesktop-iac/terraform/environments/dev/terraform.tfvars"
```

### Working with Jenkins Server
### Step-1
Now Go to project gcp-adq-pocproject-dev
Login to Jenkins server

### Step-2
Installing necessary plugins:
```
        - Docker
        - Pipeline Stage View
```
```
Dashboard--> Manage Jenkins--> Plugins --> Available plugins --> "search for plugins & Install"
```
### Step-3
Adding global credentials for:
```
        - Docker Hub.
        - Jenkins-agent(Username & Password).# Set password for Jenkins user and add to sudoers list
        - Project-dev-svc-json #set keys.json for Bucket credentials 
        - tomcat-id # set tomcat credentials for java-app 
        - github-pat (Access Token)
        - SVC_JSON_DEV(service account for jenkin pipeline)
        - sonar_token(sonarqube integration)
```
For example:
```
Manage Jenkins -> credentials -> global -> add credentials -> kind (username &
password) -> username & password (docker-hub username & password) -> Id(docker-hub) 
-> save
```
Similarly add for all other credentials.
### Step-4
Configuring Docker as Jenkins-agent.
Now here we will use our own created docker-agent

```
Dashboard--> Manage Jenkins--> Clouds--> New cloud--> Cloud name(docker)--> Type
--> Docker(select it)-->Create
```
```
	--> Docker Cloud details--> Docker Host URI--> tcp://Public-IP:4243--> Test Connection
	    Output will be like(Version = 24.0.5, API Version = 1.43)
	-->Enabled(click it)
```
```
    --> Docker Agent templates--> Add Docker Template--> Labels-->docker--> Enabled
    --> Name--> docker-agent--> Docker Image--> GIVE YOUR IMAGE
```
```
	--> Registry Authentication(select Docker Hub credentials ID)
	--> Remote File System Root--> /var/lib/jenkins
```
```
	--> Usage--> Only build jobs with label expressions matching this node
	--> Connect method--> Connect with SSH--> SSH key--> use configured SSH credentials
```
```
	--> SSH Credentials--> SSH Credentials(select jenkins-agent credentials ID)
	-->Host Key Verification Strategy-->Non verifying strategy-->save.
```
### Step-5
Create a new Pipeline job

```
Dashboard--> + New Item--> Enter an item name(adq-ubuntudesktop)--> Pipeline--> OK

NOTE: Kindly add your pipeline name as per the path of terraform code . 

source = "/var/lib/jenkins/workspace/adq-ubuntudesktop/adq-ubuntudesktop/terraform/modules/ubuntu-desktop"
```

Integrating Git for source code.

```
Pipeline-->Definition(Pipeline script from SCM)--> SCM(Git)--> Repositories
--> Repository URL(https://github.com/bpurnachander/get-ubuntudesktop-iac.git)
--> Branches to build--> Branch Specifier(*/main)-->Script Path(${JOB_NAME}/Jenkinsfile)--> Save
```

### Adding Parameters
This project is Parameterized.
Use Choice Parameters
parameters for environments:
Choice Parameter: ENV
Choices:
  * ---
  * dev
  * prod

parameters for terraform:
Choice Parameter: terraform
Choices:
  * skip
  * plan
  * apply
  * destroy 

Multi-line String Parameter: TERRAFORM_EXTRA_ARGS
Default Value: 
  * --var-file="terraform.tfvars"

parameters for ansible:
Choice Parameter: ANSIBLE
Choices:
  * skip
  * apply
  * destroy

Multi-line String Parameter: ANSIBLE_EXTRA_ARGS
Default Value:
  * playbook=$ANSIBLE
  * env=$ENV
  * softwares=all_softwares

Description:
ANSIBLE_EXTRA_ARGS: HOSTS_FILE, tomcat_base_version, tomcat_version, java_version.

HOSTS_FILE: adq_ubuntudesktop.yaml(default), all_hosts.yaml

tags: all_softwares(default), java, python, tomcat, ubuntudesktop, notepad++

NOTE: 
* Must pass "playbook=&ANSIBLE" & "env=$ENV" as it defines weather to install or uninstall software packages in particular environments.
* Adjust tags values according to softwares you want to install or uninstall.
* Add other parameters if required.

### Step-6
Build your pipeline with appropriate choices & arguments

### Troubleshooting Errors
```
1.Connection refused:
	Cause: Openssh-client not working properly.
	Remedy: Wait for few seconds after VM is created.
2.Permission denied:
	Cause: User has no permission to use private key.
	Remedy: Check the user type and change permissions of private key.
3.Host key verification failed:
	Cause: Unable to verify Host key.
	Remedy: echo 'host_key_checking = False' | sudo tee -a /etc/ansible/ansible.cfg
4.Error: Jenkins doesn’t have label ‘docker-agent’
	Remedy: Check Slave User credentials
	Terraform Errors Troubleshooting
	
5.Error 409: Resource Already Exists
6.Error 400: Syntax Error
	Remedy: Check the Syntax in Terraform Script
7.Erro 404: API error
	Remedy: Enable API for the Resources to be Created
8.If new project make sure to enable the below api to ssh the vm server:-
	1)Network Management API
	2)Cloud Identity-Aware Proxy API
 
 	ERROR Message
  	Faild to get access token
   	Unknown error
    	Retry   Troubleshoot

  	sol:- Make sure to check the network and wifi
   	OR
    	Talk with your network admin 
     	OR
      	Try with mobile network to ssh.
```
### Terraform Errors
  
![image-1](https://fortunate-headlight-ff9.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2Fffcbdfcf-e93f-43da-89e7-0ec6cd06ca40%2Ffcedd50f-c357-4095-a1eb-5a69911a8031%2FUntitled.png?table=block&id=684961f6-331f-4df7-b220-26fc61d296f3&spaceId=ffcbdfcf-e93f-43da-89e7-0ec6cd06ca40&width=1090&userId=&cache=v2)

![image-2](https://fortunate-headlight-ff9.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2Fffcbdfcf-e93f-43da-89e7-0ec6cd06ca40%2Fcfa14ec5-f93d-464e-b6e9-92121b750dca%2FUntitled.png?table=block&id=bd49b709-06ba-4d4b-beb0-0b0a01ae4d46&spaceId=ffcbdfcf-e93f-43da-89e7-0ec6cd06ca40&width=1270&userId=&cache=v2)

### Remedy-2: Remove the Lock File Manually
Since you are dealing with a local state, you can manually delete the lock file to remove the lock. 
Follow these steps:-
```
• cd /Path/to/terraform/
• rm .terraform.tfstate.lock.info
Remedy-3: Terminate the Running Terraform Processes
• ps aux | grep terraform
• kill -9 <PID>
• For eg: kill -9 1425
```
Now Retry the Terraform Command: terraform apply (state lock will be unlocked)

 
