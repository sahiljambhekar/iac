variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "my_ip" {
  description = "CIDR Range for your local machine"
  type = string
  sensitive = false
}

variable "my_ssh_id" {
  type = string
  description = "SSH Key ID for Public Key registered in HCloud"
}

variable "server_type" {
  description = "Hetzner server type for control plane and agent nodes"
  type        = string
  default     = "cx22"
}