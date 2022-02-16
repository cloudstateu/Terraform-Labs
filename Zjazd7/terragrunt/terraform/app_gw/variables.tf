variable "location" {
  type    = string
}

variable "app_gw_subscription_id" {
  type    = string
}

variable "domain_name" {
  type = string
}

variable "apps" {
  type = map(any)
}

variable "resource_tags" {
  type    = map(any)
}
