provider "google" {
  project     = "sumanth-97"
}

module "jenkins-server" {
source = "/root/get-ubuntudesktop-iac/terraform-jenkins/modules/jenkins-server"
}
