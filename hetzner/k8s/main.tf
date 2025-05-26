provider "hcloud" {
  token = var.hcloud_token
}

module "kube-hetzner" {
  providers = {
    hcloud = hcloud
  }
  hcloud_token = var.hcloud_token  # API key is now securely managed as a variable

  source = "kube-hetzner/kube-hetzner/hcloud"

  # firewall_kube_api_source = [var.my_ip] # Replace with your actual IP
  # firewall_ssh_source = [var.my_ip]
  # extra_firewall_rules = [
  #   {
  #     description = "Restrict HTTP for development"
  #     direction   = "in"
  #     port        = "80"
  #     protocol    = "tcp"
  #     source_ips  = [var.my_ip] # Replace with your IP or CIDR range
  #   },
  #   {
  #     description = "Restrict HTTPS for development"
  #     direction   = "in"
  #     port        = "443"
  #     protocol    = "tcp"
  #     source_ips  = [var.my_ip]
  #   }
  # ]

  cluster_name = "dev-cilium"
  #hcloud_ssh_key_id = var.my_ssh_id # <-- Set your Hetzner SSH key ID here
  # Create an SSH Key using Pub/Private key combo.
  ssh_public_key  = file("~/.ssh/id_rsa.pub")
  ssh_private_key = file("~/.ssh/id_rsa")

  network_region = "eu-central"

  control_plane_nodepools = [
    {
      name        = "control-plane"
      server_type = var.server_type
      location    = "hel1"
      labels      = []
      taints      = []
      count       = 1
    }
  ]

  agent_nodepools = [
    {
      name        = "no-agent"
      server_type = var.server_type
      location    = "hel1"
      labels      = []
      taints      = []
      count       = 0
    }
  ]

  load_balancer_type     = "lb11"
  load_balancer_location = "hel1" # helsinki

  ingress_controller = "none"  # Disable default ingress controllers (Traefik, Nginx)

  cni_plugin = "cilium"  # Enable Cilium as the CNI

  cilium_values = <<EOT
ingressController:
  enabled: true
  service:
    type: LoadBalancer
  resources:
    requests:
      cpu: 100m
      memory: 128Mi
    limits:
      cpu: 500m
      memory: 256Mi
EOT

  initial_k3s_channel = "v1.30"
}

output "kubeconfig" {
  value     = module.kube-hetzner.kubeconfig
  sensitive = true
}