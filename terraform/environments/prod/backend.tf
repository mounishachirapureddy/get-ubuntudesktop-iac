terraform {
  backend "gcs" {
    bucket = "adq-prod-backend-bucket"
    prefix = "terraform/state/prod"
  }
}
