variable "project_id" {
description = "custom-svc"
type = string
default = "sumanth-97"
}

variable "roles" {
  default = [
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin",
    "roles/iam.serviceAccountUser",
    "roles/compute.instanceAdmin.v1",
    "roles/storage.admin"
  ]
}
