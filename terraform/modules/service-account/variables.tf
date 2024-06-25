variable "project_id" {
  description = "The project ID where resources will be created."
  type        = string
}

variable "get_svc_id" {
  description = "The ID of the service account."
  type        = string
}

variable "get_svc_name" {
  description = "The name of the service account."
  type        = string
}

variable "roles" {
  description = "List of roles to assign to the service account."
  type        = list(string)
}
