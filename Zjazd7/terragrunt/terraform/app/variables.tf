variable "app_subscription_id" {
  type    = string
}

variable "app_name" {
  type = string
}

variable "docker_image" {
  type = string
}

variable "location" {
  type    = string
}

variable "app_settings" {
  type = map(string)
}

variable "resource_tags" {
  type    = map(any)
}
