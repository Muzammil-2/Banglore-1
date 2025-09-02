# --- Cluster Outputs ---
output "gke_cluster_name" {
  value       = google_container_cluster.main.name
  description = "The name of the GKE cluster"
}

output "gke_cluster_location" {
  value       = google_container_cluster.main.location
  description = "The region/zone where the GKE cluster is deployed"
}

output "gke_cluster_endpoint" {
  value       = google_container_cluster.main.endpoint
  description = "The endpoint for the GKE control plane"
}

output "gke_cluster_ca_certificate" {
  value       = google_container_cluster.main.master_auth[0].cluster_ca_certificate
  description = "The base64 encoded public CA certificate for the GKE cluster"
  sensitive   = true
}

# --- Node Pool Outputs ---
output "gke_node_pools" {
  value = {
    for k, np in google_container_node_pool.main :
    k => {
      name       = np.name
      node_count = np.node_count
      version    = np.version
    }
  }
  description = "Details of all GKE node pools (
