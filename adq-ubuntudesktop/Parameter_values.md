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
