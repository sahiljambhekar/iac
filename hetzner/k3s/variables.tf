variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "my_ips" {
  description = "CIDR Ranges for your local machine(s)"
  type        = list(string)
  sensitive   = false
}

variable "location" {
  # They recently came into Ashburn. 
  type    = string
  default = "ash"

}

variable "region" {
  description = "Hetzner Cloud region for the Kubernetes cluster"
  type        = string
  default     = "us-east"
}


variable "server_large" {
  description = "Hetzner server type for large nodes (default ARM for ASH)"
  type        = string
  default     = "cax21"
}

locals {
  # You have the choice of setting your Hetzner API token here or define the TF_VAR_hcloud_token env
  # within your shell, such as: export TF_VAR_hcloud_token=xxxxxxxxxxx
  # If you choose to define it in the shell, this can be left as is.

  # Your Hetzner token can be found in your Project > Security > API Token (Read & Write is required).
  hcloud_token = var.hcloud_token

  # ARM server types for ASH (us-east)
  arm_small  = "cax11"
  arm_medium = "cax21"
  arm_large  = "cax31"

  # AMD server types for AHS (us-east)
  amd_small  = "cpx11"
  amd_medium = "cpx21"
  amd_large  = "cpx31"

  control_plane_loc = var.location
}
