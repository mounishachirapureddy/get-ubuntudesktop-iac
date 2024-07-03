variable "network_name" {
  description = "The name of the network."
  type        = string
}

variable "subnet01_name" {
  description = "The name of the first subnet."
  type        = string
}

variable "subnet01_region" {
  description = "The region for the first subnet."
  type        = string
}

variable "subnet01_cidr" {
  description = "The CIDR block for the first subnet."
  type        = string
}

variable "firewall01_name" {
  description = "The name of the first firewall rule."
  type        = string
}

variable "firewall02_name" {
  description = "The name of the second firewall rule."
  type        = string
}

variable "firewall03_name" {
  description = "The name of the third firewall rule."
  type        = string
}


variable "firewall01_network_tags" {
  description = "The network tags for the first firewall rule."
  type        = string
}

variable "firewall02_network_tags" {
  description = "The network tags for the second firewall rule."
  type        = string
}

variable "firewall03_network_tags" {
  description = "The network tags for the third firewall rule."
  type        = string
}

variable "get_ubuntudesktop_static_ip_name" {
  description = "get_ubuntudesktop_static_ip_name."
  type        = string
}

variable "project_region" {
  description = "project_region."
  type        = string
}
