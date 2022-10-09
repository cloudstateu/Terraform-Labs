locals {
  vnet_name          = "vnet-${var.resources_suffix}"
  sbn_app_svc_name   = "sbn-app-svc-${var.resources_suffix}"
  sbn_endpoints_name = "sbn-endpoints-${var.resources_suffix}"
  kv_name            = "kv-app-${var.resources_suffix}"
  storage_name       = "saapp${var.resources_suffix}"
  mysql_server_name  = "db-app-${var.resources_suffix}"
  service_plan_name  = "svc-plan-${var.resources_suffix}"
  app_name           = "svc-app-${var.resources_suffix}"
  frontdoor_name     = "fd-app-${var.resources_suffix}"
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
