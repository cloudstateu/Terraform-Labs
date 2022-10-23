variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "containers" {
  type = map(object({
    name = string
  }))
}
