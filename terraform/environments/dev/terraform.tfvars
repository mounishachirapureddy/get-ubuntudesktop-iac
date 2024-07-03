project_id        = "gcp-adq-pocproject-dev"
project_region                   = "us-central1"
get_ubuntudesktop_static_ip_name = "get-ubuntudesktop-static-ip"
network_name      = "get-dev-network"
subnet01_name     = "get-dev-subnet"
subnet01_region   = "us-central1"
subnet01_cidr     = "10.0.1.0/24"
firewall01_name   = "ubuntudesktop"
firewall02_name   = "tomcat"
firewall03_name   = "apache2"
firewall01_network_tags   = "desktop-server"
firewall02_network_tags   = "tomcat-server"
firewall03_network_tags   = "apache2-server"

get_svc_id   = "adq-dev-svc"
get_svc_name = "adq-dev-svc"

roles = [
  "roles/compute.networkAdmin",
  "roles/compute.securityAdmin",
  "roles/iam.serviceAccountUser",
  "roles/compute.instanceAdmin.v1",
  "roles/storage.admin"
]

