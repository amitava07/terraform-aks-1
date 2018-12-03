provider "azurerm" {
}

terraform {
  backend "azurerm" {}
}

module "aks" {
  source                = "../../modules/aks"

  client_id             = "${var.client_id}"
  client_secret         = "${var.client_secret}"
  agent_count           = "${var.agent_count}"
  ssh_public_key        = "${var.ssh_public_key}"
  dns_prefix            = "${var.dns_prefix}"
  node_admin_username   = "${var.node_admin_username}"
  os_disk_size_gb       = "${var.os_disk_size_gb}"
  os_type               = "${var.os_type}"
  vm_size               = "${var.vm_size}"
  cluster_name          = "${var.cluster_name}"
  resource_group_name   = "${var.resource_group_name}"
  location              = "${var.location}"
  environment           = "${var.environment}"
}
