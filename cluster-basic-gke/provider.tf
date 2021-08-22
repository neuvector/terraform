provider "google" {
  #version = "~> 3.49.0"
  project = var.project_id
  region  = var.region
}

terraform {
  #required_version = ">= 0.13"
}