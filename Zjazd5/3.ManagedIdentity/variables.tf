locals {
  user_assigned_identity_name = "vm-identity-${var.resources_suffix}"
  storage_name                = "storage0123${var.resources_suffix}"
  network_name                = "network-${var.resources_suffix}"
  subnet_name                 = "subnet-${var.resources_suffix}"
  nic_name                    = "nic-${var.resources_suffix}"
  vm_name                     = "vm-${var.resources_suffix}"
  pip_name                    = "pip-${var.resources_suffix}"
}

variable "subscription_id" {
  type = string
  default = "4e363600-faee-4b13-8f77-738d7d3cb478"
}

variable "resource_group_name" {
  type = string
  default = "ManagedIdentity"
}

variable "resources_suffix" {
  type = string
  default = "mw"
}
