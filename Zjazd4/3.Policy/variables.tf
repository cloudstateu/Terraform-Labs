locals {
  policy_name                 = "policy-locations-${var.resources_suffix}"
  policy_assigment_name       = "policy-locations-assigment-${var.resources_suffix}"
  policy_tags_name            = "policy-tags-${var.resources_suffix}"
  policy_assigment_sizes_name = "policy-locations-assigment-sizes-${var.resources_suffix}"
  kv_name                     = "kv-app-${var.resources_suffix}"
}

variable "subscription_id" {
  type    = string
  default = "79283b62-f23b-4420-9ae7-1ac41de00335"
}

variable "resource_group_name" {
  type    = string
  default = "link4-student0"
}

variable "resources_suffix" {
  type    = string
  default = "student0"
}
