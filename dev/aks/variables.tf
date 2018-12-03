variable "subscription_id" {}
variable "tenant_id" {}
variable "client_id" {}
variable "client_secret" {}

variable "agent_count" {
  default = "1"
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "inmobi.k8s.test"
}

variable cluster_name {
  default = "inmobi-k8s-test-cluster"
}

variable resource_group_name {
  default = "inmobi-k8s-test-rsg"
}

variable location {
  default = "South India"
}

variable "environment" {
  default = "Development"
}

variable "node_admin_username" {
  default = "inmobi"
}

variable "os_disk_size_gb" {
  default = 30
}

variable "os_type" {
  default = "Linux"
}

variable "vm_size" {
  default = "Standard_DS2_v2"
}