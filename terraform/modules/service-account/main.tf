resource "google_service_account" "get_svc" {
  account_id   = var.get_svc_id
  display_name = var.get_svc_name
  project      = var.project_id
}

resource "google_project_iam_binding" "get_svc_role_bindings" {
  count   = length(var.roles)
  project = var.project_id
  role    = var.roles[count.index]
  
  members = [
    "serviceAccount:${google_service_account.get_svc.email}"
  ]
}

