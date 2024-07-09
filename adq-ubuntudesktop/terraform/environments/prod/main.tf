provider "google" {
  project     = var.project_id
}

module "ubuntu-desktop" {
source = "/var/lib/jenkins/workspace/adq-ubuntudesktop/adq-ubuntudesktop/terraform/modules/ubuntu-desktop"

desktop_server_name 			= var.desktop_server_name
get_desktop_machine_type		= var.get_desktop_machine_type
get_desktop_zone			= var.get_desktop_zone
get_desktop_image			= var.get_desktop_image
get_desktop_boot_size			= var.get_desktop_boot_size
network					= var.network
subnetwork				= var.subnetwork
svc_email				= var.svc_email
get_desktop_network_tag			= var.get_desktop_network_tag
ubuntudesktop_static_ip     = var.ubuntudesktop_static_ip
}
