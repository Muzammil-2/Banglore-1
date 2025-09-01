google_compute_network "network"{
    name = gcp_vpc
    region = us-central-1
}

google_compute_subnetwork "sunetwork" {
    network = google_compute_network.network.selflink
    name = pub_subnet
    cidr =  ["172.16.1.0/24"]
    availability_zone = "us-west-1a
}

google_cloud_router "rt-gcp"  {
    name = rt-gcp
    network = google_compute_network.network.selflink

    rout {
        source = ["0.0.0.0"]
        cidr = ["172.16.1.0/24]
    }
}
google_compute_instance "instance" {
    name = gcp-instance
    network = google_compute_network.network.selflink
    subnetwork= google_compute_subnetwork.sunetwork.id
    machine_type= "e2-medium"
    launch_public_ip = true
}