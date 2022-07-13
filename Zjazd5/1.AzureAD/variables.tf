locals {
  user_name            = "user01-${var.resources_suffix}@chmurowiskolab.onmicrosoft.com"
}

variable "resources_suffix" {
  type = string
}
