provider "google" {
  project     = var.project_id
  region      = var.project_region
}

terraform {
  backend "gcs" {
    bucket = "jenkins-box-backend-bucket"
    prefix = "terraform/state/jenkins"
  }
}

module "adq-jenkins-box" {
source = "/root/get-ubuntudesktop-iac/adq-jenkins-box/modules/adq-jenkins-box"

get_jenkins_name                = var.get_jenkins_name
get_jenkins_machine_type        = var.get_jenkins_machine_type
get_jenkins_zone                = var.get_jenkins_zone
get_jenkins_image               = var.get_jenkins_image
get_jenkins_boot_size           = var.get_jenkins_boot_size
get_jenkins_network_tag         = var.get_jenkins_network_tag
network				                  = var.network
subnetwork			                = var.subnetwork
svc_email   			              = var.svc_email
jenkins_box_firewall_name	      = var.jenkins_box_firewall_name
jenkins_box_static_ip_name      = var.jenkins_box_static_ip_name
project_region                  = var.project_region
}
