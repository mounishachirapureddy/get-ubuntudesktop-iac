variable "project_id" {
  description = "project_id."
  type        = string
}

variable "get_jenkins_name" {
  description = "get_jenkins_name."
  type        = string
}

variable "get_jenkins_machine_type" {
  description = "get_jenkins_machine_type."
  type        = string
}

variable "get_jenkins_zone" {
  description = "get_jenkins_zone."
  type        = string
}

variable "get_jenkins_image" {
  description = "get_jenkins_image."
  type        = string
}

variable "get_jenkins_boot_size" {
  description = "get_jenkins_boot_size."
  type        = number
}

variable "get_jenkins_network_tag" {
  description = "get_jenkins_network_tag."
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

variable "jenkins_box_firewall_name" {
  description = "jenkins_box_firewall_name."
  type        = string
}

variable "project_region" {
  description = "project_region."
  type        = string
}

variable "jenkins_box_static_ip_name" {
  description = "jenkins_box_static_ip_name."
  type        = string
}
