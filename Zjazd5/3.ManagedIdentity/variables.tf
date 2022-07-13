locals {
  user_assigned_identity_name = "vm-identity-${var.resources_suffix}"
  storage_name                = "storage${var.resources_suffix}"
  network_name                = "network-${var.resources_suffix}"
  subnet_name                 = "subnet-${var.resources_suffix}"
  nic_name                    = "nic-${var.resources_suffix}"
  vm_name                     = "vm-${var.resources_suffix}"
  pip_name                    = "pip-${var.resources_suffix}"
}

variable "subscription_id" {
  type = string
  default = "79283b62-f23b-4420-9ae7-1ac41de00335"
}

variable "resource_group_name" {
  type = string
  default = "link4-student0"
}

variable "resources_suffix" {
  type = string
  default = "spniak"
}
