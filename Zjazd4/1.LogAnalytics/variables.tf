locals {
  log_name            = "log-${var.resources_suffix}"
  kv_name             = "kv-app-${var.resources_suffix}"
  service_plan_name   = "svc-plan-${var.resources_suffix}"
  app_name            = "svc-app-${var.resources_suffix}"
  diagnostic_settings = "diagnostic-settings-${var.resources_suffix}"
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
