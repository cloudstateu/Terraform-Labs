locals {
  vnet_name          = "vnet-${var.resources_suffix}"
  sbn_app_svc_name   = "sbn-app-svc-${var.resources_suffix}"
  sbn_endpoints_name = "sbn-endpoints-${var.resources_suffix}"
  kv_name            = "kv-app-${var.resources_suffix}"
  storage_name       = "saapp${var.resources_suffix}"
}

variable "subscription_id" {
  type    = string
  default = "79283b62-f23b-4420-9ae7-1ac41de00335"
}

variable "resource_group_name" {
  type    = string
  default = "bank-student0"
}

variable "resources_suffix" {
  type    = string
  default = "student0"
}
