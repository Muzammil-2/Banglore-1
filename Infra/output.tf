# --- Backend related outputs ---
output "gcs_bucket_name" {
  value       = google_storage_bucket.terraform_state.name
  description = "The name of the GCS bucket used for Terraform state"
}

# Optional Firestore lock DB
output "firestore_database_name" {
  value       = try(google_firestore_database.terraform_locks.name, "(not enabled)")
  description = "The Firestore database used for Terraform state locking (if enabled)"
}

# --- VPC outputs ---
output "vpc_network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC network"
}

output "vpc_subnet_names" {
  value       = module.vpc.subnet_names
  description = "The names of the subnets created in the VPC"
}

# --- GKE outputs ---
output "gke_cluster_name" {
  value       = module.gke.cluster_name
  description = "The name of the GKE cluster"
}

output "gke_cluster_endpoint" {
  value       = module.gke.endpoint
  description = "The endpoint for the GKE cluster"
}

output "gke_cluster_ca_certificate" {
  value       = module.gke.ca_certificate
  description = "The base64 encoded public CA certificate for the cluster"
  sensitive   = true
}
