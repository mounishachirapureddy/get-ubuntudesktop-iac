terraform {
  backend "gcs" {
    bucket = "adq-dev-backend-bucket"
    prefix = "terraform/state/desktop"
  }
}
