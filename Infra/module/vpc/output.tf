# --- VPC Outputs ---
output "vpc_name" {
  value       = google_compute_network.main.name
  description = "The name of the VPC network"
}

output "vpc_self_link" {
  value       = google_compute_network.main.self_link
  description = "The self link of the VPC network"
}

# --- Private Subnet Outputs ---
output "private_subnet_names" {
  value       = [for s in google_compute_subnetwork.private : s.name]
  description = "Names of the private subnets"
}

output "private_subnet_self_links" {
  value       = [for s in google_compute_subnetwork.private : s.self_link]
  description = "Self links of the private subnets"
}

output "private_subnet_cidrs" {
  value       = [for s in google_compute_subnetwork.private : s.ip_cidr_range]
  description = "CIDR ranges of the private subnets"
}

# --- Public Subnet Outputs ---
output "public_subnet_names" {
  value       = [for s in google_compute_subnetwork.public : s.name]
  description = "Names of the public subnets"
}

output "public_subnet_self_links" {
  value       = [for s in google_compute_subnetwork.public : s.self_link]
  description = "Self links of the public subnets"
}

output "public_subnet_cidrs" {
  value       = [for s in google_compute_subnetwork.public : s.ip_cidr_range]
  description = "CIDR ranges of the public subnets"
}

# --- NAT & Router Outputs ---
output "cloud_router_name" {
  value       = google_compute_router.main.name
  description = "Name of the Cloud Router used for NAT"
}

output "cloud_nat_name" {
  value       = google_compute_router_nat.main.name
  description = "Name of the Cloud NAT configuration"
}
