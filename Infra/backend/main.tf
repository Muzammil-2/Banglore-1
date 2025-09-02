provider "google" {
  project = var.project_id
  region  = var.region
}

# GCS bucket for Terraform state
resource "google_storage_bucket" "terraform_state" {
  name     = "demo-terraform-eks-state-gcs-bucket"  # must be globally unique
  location = var.region
  storage_class = "STANDARD"

  # Versioning (like aws_s3_bucket_versioning)
  versioning {
    enabled = true
  }

  # Encryption is on by default (AES256). 
  # If you want CMEK, add `encryption` block.
  uniform_bucket_level_access = true

  lifecycle {
    prevent_destroy = false
  }
}

# OPTIONAL: Firestore setup for state locking
# Note: Firestore database must be created manually in console the first time 
# because Terraform can't enable it directly.

resource "google_firestore_database" "terraform_locks" {
  name        = "(default)"
  location_id = var.region
  type        = "FIRESTORE_NATIVE"
}

terraform {
  backend "gcs" {
    bucket  = "demo-terraform-eks-state-gcs-bucket"
    prefix  = "terraform/state"
  }
}