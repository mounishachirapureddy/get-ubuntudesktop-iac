provider "google" {
  project     = "sumanth-97"
}

terraform {
  backend "gcs" {
    bucket  = "sumanth-state-backup-bucket"
    prefix  = "terraform-infra/state"
  }
}

module "jenkins-server" {
source = "/root/get-ubuntudesktop-iac/terraform/modules/jenkins-server"
}
