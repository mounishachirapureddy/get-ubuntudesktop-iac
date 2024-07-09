terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5"
    }
  }
}


provider "google" {
  project = var.project_id
}

module "networking" {
  source    = "/root/get-ubuntudesktop-iac/terraform/modules/networking"

  network_name            = var.network_name
  subnet01_name           = var.subnet01_name
  subnet01_region         = var.subnet01_region
  subnet01_cidr           = var.subnet01_cidr
  firewall01_name         = var.firewall01_name
  firewall02_name         = var.firewall02_name
  firewall03_name         = var.firewall03_name
  firewall01_network_tags = var.firewall01_network_tags
  firewall02_network_tags = var.firewall02_network_tags
  firewall03_network_tags = var.firewall03_network_tags
  project_region                          = var.project_region
  get_ubuntudesktop_static_ip_name        = var.get_ubuntudesktop_static_ip_name
}

module "service-account" {
  source    = "/root/get-ubuntudesktop-iac/terraform/modules/service-account"

  project_id              = var.project_id
  get_svc_id		          = var.get_svc_id
  get_svc_name	      	  = var.get_svc_name
  roles			              = var.roles

}
