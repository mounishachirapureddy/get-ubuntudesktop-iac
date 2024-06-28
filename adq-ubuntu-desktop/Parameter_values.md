parameters for environments:
parameter: ENV
  * ---
  * dev
  * prod

parameters for terraform:
parameter: tfm_action
  * ---
  * init
  * plan
  * apply
  * destroy
  * skip

parameters for ansible_hosts:
parameter: ansible_hosts
  * ---
  * ubuntudesktop

parameters for ansible_action:
parameter: ansible_action
  * ---
  * apply
  * destroy
  * skip

parameters for software:
parameter: software
  * all
  * desktop
  * tomcat
  * python
  * java

parameters for software_versions:
parameter: python_version
  * 3

parameter: java_version
  * 11
  * 17
  * 8

parameter: tomcat_base_version
  * 9
  * 10

parameter: tomcat_version
  * 9.0.89
  * 9.0.90
  * 10.1.24
  * 10.1.25

parameter: upgrade_software
  * tomcat


ansible command:
---
* ansible-playbook -e "ansible_hosts=<your_option> software=<your_option> version=<your_option> operation=<your_option>" master.yaml

NOTE: Add parameters
  ---
  * Docker Hub credentials as "username and password".
  * Jenkins credentials as "username and password".
  * Service-account credentials as "secretfile".
  * GitHub credentials as "username and password". (password= token)
