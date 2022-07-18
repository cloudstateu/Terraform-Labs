variable "spoke_resource_group_name" {
  type = string
}

variable "spoke_number" {
  type = number
}

variable "location" {
  type = string
}

variable "address_prefix" {
  type = list(string)
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "hub_virtual_network_id" {
  type = string
}

variable "hub_virtual_network_name" {
  type = string
}

variable "hub_resource_group_name" {
  type = string
}
