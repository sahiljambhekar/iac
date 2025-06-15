provider "hcloud" {
  token = var.hcloud_token
}

module "k3s_hetzner_cluster" {
  source  = "some-community/k3s-hetzner/hcloud" # Example module source - replace with a specific one
  version = "x.y.z" # Specify the module version

  hcloud_token = var.hcloud_token
  cluster_name = "my-learning-k3s"
  ssh_keys     = [""] # The name of your SSH key in Hetzner Cloud

  # --- Master/Control Plane Node Configuration ---
  server_type_master = var. # Smallest server type for learning (e.g., 2 vCPU, 2 GB RAM)
  master_count         = 1     # For learning, one master is usually sufficient

  # --- Worker Node Configuration ---
  server_type_worker = "cpx11" # Can be the same or different from master
  worker_count       = 1     # Start with one worker, you can scale later

  # --- Networking (often handled by the module) ---
  # The module will likely create a private network.

  # --- Location ---
  location = "nbg1" # Choose a Hetzner location (e.g., nbg1, fsn1, hel1)

  # --- K3s Version ---
  # k3s_version = "v1.28.x+k3s1" # Specify if needed, otherwise module default

  # --- Additional Features (check module documentation) ---
  # Some modules might offer options to install:
  # - Hetzner Cloud Controller Manager (CCM) - for LoadBalancer services & node lifecycle
  # - Hetzner CSI Driver - for PersistentVolumes
  # - Ingress Controller (e.g., Traefik, which comes with K3s by default)
}