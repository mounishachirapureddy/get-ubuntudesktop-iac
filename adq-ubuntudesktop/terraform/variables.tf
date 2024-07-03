variable "project_id" {
  description = "project_id."
  type        = string
}

variable "desktop_server_name" {
  description = "desktop_server_name."
  type        = string
}

variable "get_desktop_machine_type" {
  description = "get_desktop_machine_type."
  type        = string
}

variable "get_desktop_zone" {
  description = "get_jenkins_zone."
  type        = string
}

variable "get_desktop_image" {
  description = "get_jenkins_image."
  type        = string
}

variable "get_desktop_boot_size" {
  description = "get_jenkins_boot_size."
  type        = number
}

variable "get_desktop_network_tag" {
  description = "get_desktop_network_tag."
  type        = string
}

variable "network" {
  description = "network."
  type        = string
}

variable "subnetwork" {
  description = "subnetwork."
  type        = string
}

variable "svc_email" {
  description = "svc_email."
  type        = string
}

variable "ubuntudesktop_static_ip" {
  description = "ubuntudesktop_static_ip."
  type        = string
}
