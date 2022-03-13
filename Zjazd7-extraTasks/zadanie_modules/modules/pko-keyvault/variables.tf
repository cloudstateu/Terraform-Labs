variable "resource-group-name" {
  description = "Resouce group to which KV should be deployed"
}

variable "key-vault-name" {
  description = "Name of KV"
}

variable "key-vault-sku" {
  default = "standard"
  description = "SKU of KV"
}