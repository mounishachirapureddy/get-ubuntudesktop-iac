# ADQ-JAVA-APP-DEPLOYMENT

### Pre-requisites: 
1. Jenkins-sever – with Firewall rules allowing ports: 8080, 8081, 9000, 4243, 80, 22
2. Install SonarQube in Jenkins server using [sonar.sh] script in below GitHub
3. Nexus setup
4. Tomcat server

Repository: https://github.com/SaravanaNani/ansible-setup-gcp.git

### Note: After installing sonarqube – start the soanrqube follow the below steps to start SonarQube
### run this on server manually as sonar-user

```
• cd /opt/sonarqube-9.9.6.92038/bin/linux-x86-64/
• sh sonar.sh start
• sh sonar.sh status

```

3. Install Nexus in Jenkins Server manually using the steps in below GitHub Repository
(nexus manual setup) –> https://github.com/SaravanaNani/ansible-setup-gcp.git

5. Tomcat Sever – Using playbook install Tomcat in Ubuntu desktop server 

### Note: The Jenkinsfile and Source code for this Deployment is taken from below GitHub Repo

Repository: https://github.com/SaravanaNani/jenkins-java-project.git

### SonarQube step-up:

### Step1 – Login into SonarQube console where initial Username & Password = admin
### Step2 – Create a project in SonarQube:
–> Projects –> create project –> manually –> Project display name (adq-java-app) 

![image](https://github.com/user-attachments/assets/17eb08fa-06b6-45f5-badb-e40097426ff7)

–> Project key (adq-java-app) –> Main branch name (master) –> click setup 

![image](https://github.com/user-attachments/assets/bd0d39fc-acf7-44a4-852f-fce1c402e9fd)

–> How do you want to analyze your repository?

![image](https://github.com/user-attachments/assets/8ed6799a-3c43-4673-833f-d089dc516cf3)

–> locally –> Token name (adq-java-app) –> Generate token and copy it


### Step3 – Get into Jenkins Console Paste SonarQube token in Global Credentials:
–> Manage Jenkins –> credentials –> global –> Add Credentials –> Kind (Secrete Text) 
–> Paste token - ID (sonar_token) –> description (sonar-token) –> save

![image](https://github.com/user-attachments/assets/622ae45d-ea38-4f35-845e-d3989294e7b8)
### sonar_token
![image](https://github.com/user-attachments/assets/b5edb15e-9d41-4cc1-aa0a-96e4bf064ab4)


### Step4 – Generate GitHub classic token and paste it in global credentials.
### GitHub Token Generation:
–> Settings –> Developer Setting –> Personal Access Token –> Tokens (classic) 
–> Generate new token –> new classic token –> Note (adq-java-app) 
–> Select the required permission to token –> Generate Token.
–> Copy token and paste in Jenkins Global credentials:
–> Manage Jenkins –> credentials –> global –> Add Credentials –> Kind (Secrete Text) 
–> Paste token - ID (github-pat) - description (GIT-PAT) - save


### Step5 – Install Sonar Scanner plugin and Set SonarQube system configuration in Jenkins console:
1. Goto Jenkins Dashboard –> Manage Jenkins –> Plugins –> available plugins 
–> SonarSonarQube Scanner

![image](https://github.com/user-attachments/assets/e0b7afd2-4a7f-430f-9a8d-7c2a5bcc1b94)

3. Goto Jenkins Dashboard –> Manage Jenkins –> System configuration –> System 
–> SonarQube servers: –> Enable Environment variables 
–> SonarQube installations –> name (Sonar) –> Server URL (paste SonarQube URL) 
–> Server authentication token (select updated token credentials in above step) –> save


### Step6 – Set SonarQube path in tools Jenkins console:
–> Goto Jenkins Dashboard –> Manage Jenkins –> tools –> SonarQube Scanner installations
–> name (sonar) –> select install automatically –> save

![image](https://github.com/user-attachments/assets/e0b7afd2-4a7f-430f-9a8d-7c2a5bcc1b94)

### Nexus Setup:
### Required plugin in jenkins for Nexus:
![image](https://github.com/user-attachments/assets/c37d2130-c368-412e-b76c-ebde0e6a25fb)

### Step1 – Create a Repository in Nexus:
### To create Repository: 
–> Login to Nexus Console (using nexus VM - ExternalIP:8081) 
–> Initial Username & Password = admin –> Click on Setting Icon –> Repositories 
–> Create repositories –> (maven2 hosted) –> Repo Name (adq-java-app) 
–> Deployment Policy Select (Allow Redeploy) –> Create Repository

![image](https://github.com/user-attachments/assets/27bc95a6-668d-4b33-a4ea-8994449146f7)
![image](https://github.com/user-attachments/assets/300b904f-73d6-49db-ba60-b5e656f83a75)
![image](https://github.com/user-attachments/assets/4e8418f1-c37e-4d79-9357-36ae90f684d2)
![image](https://github.com/user-attachments/assets/969e9740-31a2-4e86-8710-9f4961186545)
![image](https://github.com/user-attachments/assets/55446ab8-94fd-4b07-b6fc-24bc57946379)
![image](https://github.com/user-attachments/assets/a2e92fe7-23d1-4824-8aaa-f319f397bdf8)

### Step2 – Create a Pipeline Syntax for upload artifact to Nexus:
### Click on –> Pipeline Syntax –> Sample Step (Nexus Artifact Uploader) 
```
–> Nexus Version (NEXUS3) –> Protocol (HTTP) 
–> Nexus URL (copy & Paste nexus EXTERNALIP:8081) 
–> Credentials –> Add (Jenkins) –> kind (Username & Password) 
–> Username (nexus-username [admin]) Password (nexus login password)
–> ID (nexus_token) –> Description(nexus) –> Add 
–> Click on Artifacts –> Artifact (NEXUS_ARTIFACT_ID) –> Type (war) 
–> Classifier (leave it blank) –> File (target/ JAVA_APP-1.2.${BUILD_NUMBER})
–> Generate Pipeline Syntax (copy & paste in pipeline stage nexus)

```

### Note: The below given details are for the Jave application Code used here in this Task. Below 
### Details vary for other Java application Code, you find it in POM.XML file 
```
NEXUS_REPOSITORY = 'adq-java-app'
NEXUS_GROUP_ID = 'in.ADQ-JAVA-APP' 
NEXUS_ARTIFACT_ID = 'JAVA_APP'
```
