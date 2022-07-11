locals {
  policy_name           = "policy-locations-${var.resources_suffix}"
  policy_assigment_name = "policy-locations-assigment-${var.resources_suffix}"
  policy_tags_name = "policy-tags-${var.resources_suffix}"
  policy_assigment_tags_name = "policy-locations-assigment-tags-${var.resources_suffix}"
  kv_name               = "kv-app-${var.resources_suffix}"
}

variable "subscription_id" {
  type    = string
  default = "6b76b812-84c7-41d9-825a-707b30826dc4"
}

variable "resource_group_name" {
  type    = string
  default = "szkolenietf"
}

variable "resources_suffix" {
  type    = string
  default = "sp"
}
