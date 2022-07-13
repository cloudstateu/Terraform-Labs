locals {
  user_name                = "user01-${var.resources_suffix}@chmurowiskolab.onmicrosoft.com"
  role_rgcreator_name      = "role-rgcreator-${var.resources_suffix}"
  role_nsgcontributor_name = "role-nsgcontributor-${var.resources_suffix}"
  nsg_name                 = "nsg-${var.resources_suffix}"
}

variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "resources_suffix" {
  type = string
}
