project_id   = "my-gcp-project"
region       = "us-central1"
vpc_network  = "my-vpc"
subnetwork   = "my-subnet"
cluster_name = "demo-gke-cluster"

node_groups = {
  "default-pool" = {
    instance_types = ["e2-medium"]
    capacity_type  = "ON_DEMAND"
    scaling_config = {
      min_size     = 1
      desired_size = 2
      max_size     = 3
    }
  }
  "spot-pool" = {
    instance_types = ["e2-small"]
    capacity_type  = "SPOT"
    scaling_config = {
      min_size     = 0
      desired_size = 1
      max_size     = 2
    }
  }
}
