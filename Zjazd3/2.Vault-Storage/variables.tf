locals {
  vnet_name          = "vnet-${var.resources_suffix}"
  sbn_app_svc_name   = "sbn-app-svc-${var.resources_suffix}"
  sbn_endpoints_name = "sbn-endpoints-${var.resources_suffix}"
  kv_name            = "kv-app-${var.resources_suffix}"
  storage_name       = "saapp${var.resources_suffix}"
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
