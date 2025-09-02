project_id   = "my-gcp-project"
region       = "us-central1"
cluster_name = "demo-gke"

private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]

private_pods_cidrs     = ["10.1.0.0/16", "10.2.0.0/16"]
private_services_cidrs = ["10.3.0.0/20", "10.4.0.0/20"]
