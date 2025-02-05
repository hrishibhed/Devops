# Configure the DigitalOcean provider


# testiing! 
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token  # DigitalOcean API token
}

# Create a Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "do-cluster" {
  name    = "k8stest-cluster"
  region  = "blr1"  # Change to your preferred region
  version = "1.31.1-do.5"  # Specify the Kubernetes version

  tags = ["production", "k8s"]

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb"  # Node size (2 vCPU, 4GB RAM)
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 3
    tags       = ["node-pool"]
  }

  # Optional: Specify an SSH key for accessing the nodes
  #ssh_keys = [var.ssh_key_id]  # Uncomment and provide the SSH key ID
}

# Output the kubeconfig file for the cluster
output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.do-cluster.kube_config[0].raw_config
  sensitive = true
}

# # Wait for the Kubernetes cluster to be fully created
# resource "null_resource" "wait_for_cluster" {
#   provisioner "local-exec" {
#     command = "sleep 60"  # Adjust the sleep time as needed
#   }

#   depends_on = [digitalocean_kubernetes_cluster.do-cluster]
# }

# # Optionally, create a firewall for the Kubernetes cluster
# resource "digitalocean_firewall" "do-firewall" {
#   name = "do-k8s-firewall"

#   # Extract the droplet IDs from the node pool
# droplet_ids = [for node in digitalocean_kubernetes_cluster.do-cluster.node_pool[0].nodes : node.droplet_id]

#   inbound_rule {
#     protocol         = "tcp"
#     port_range       = "6443"
#     source_addresses = ["0.0.0.0/0"]  # Allow access to the Kubernetes API server
#   }

#   inbound_rule {
#     protocol         = "tcp"
#     port_range       = "22"
#     source_addresses = ["0.0.0.0/0"]  # Allow SSH access to the nodes
#   }

#   inbound_rule {
#     protocol         = "tcp"
#     port_range       = "30000-32767"
#     source_addresses = ["0.0.0.0/0"]  # Allow NodePort services
#   }
#     inbound_rule {
#     protocol         = "tcp"
#     port_range       = "80"
#     source_addresses = ["0.0.0.0/0"]  # Allow http services
#   }
#     inbound_rule {
#     protocol         = "tcp"
#     port_range       = "443"
#     source_addresses = ["0.0.0.0/0"]  # Allow https services
#   }
  
  

#   outbound_rule {
#     protocol              = "icmp"
#     destination_addresses = ["0.0.0.0/0"]
#   }

#   outbound_rule {
#     protocol              = "tcp"
#     port_range            = "all"
#     destination_addresses = ["0.0.0.0/0"]
#   }

#   outbound_rule {
#     protocol              = "udp"
#     port_range            = "all"
#     destination_addresses = ["0.0.0.0/0"]
#   }

#   depends_on = [null_resource.wait_for_cluster]
# }