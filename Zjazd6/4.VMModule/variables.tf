#Should be overwritten by a safe password variable stored in a safe way (not in file) like local variables
variable "username" {
  type    = string
  default = "admin1234"
}

#Should be overwritten by a safe password variable stored in a safe way (not in file) like local variables
variable "password" {
  type    = string
  default = "Password1234"
}

variable "hub_subscription_id" {
  type = string
}

variable "spoke_subscription_id" {
  type = string
}

variable "hub_resource_group_name" {
  type = string
}

variable "spoke_resource_group_name" {
  type = string
}
