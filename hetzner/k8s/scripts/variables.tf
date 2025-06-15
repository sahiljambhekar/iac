variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "my_ips" {
  description = "CIDR Ranges for your local machine(s)"
  type = list(string)
  sensitive = false
}

variable "location" {
  type = string
  default = "FSN1"
  
}