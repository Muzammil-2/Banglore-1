terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  # Remote backend in GCS (instead of S3 + DynamoDB)
  backend "gcs" {
    bucket  = "demo-terraform-gke-state-bucket"  # must exist first
    prefix  = "terraform/state"                  # like 'key' in S3
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# VPC module (like AWS VPC)
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  subnets            = var.subnets
  secondary_ranges   = var.secondary_ranges
  network_name       = var.network_name
}

# GKE module (instead of AWS EKS)
module "gke" {
  source = "./modules/gke"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  network         = module.vpc.network_name
  subnets         = module.vpc.subnet_names
  node_pools      = var.node_pools
}
