terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.0.1"
    }
  }
}

terraform {
  backend "gcs" {
    bucket      = "<BUCKET_NAME>"      # GCS bucket name
    prefix      = "terraform/state"    # Folder path inside bucket
    credentials = "<PATH_TO_KEY>.json" # Optional if not using ADC
  }
}
provider "google" {
  project     = "my-project-id"
  region      = "us-central1"
  zone        = "us-central1-c"
}

