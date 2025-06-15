variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "server_type" {
  description = "Hetzner server type for control plane and agent nodes"
  type        = string
  default     = "cx22"
}