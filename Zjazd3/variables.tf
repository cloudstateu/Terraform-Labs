variable "sub-id" {
  type = string
  default = "f2744546-f752-4860-a295-32087daf1665"
}

variable "rg-name" {
  type = string
  default = "tf-st60-rg"
}

variable "app-serv-name" {
    type = string
    default = "aps-mf-dev-01"
}

variable "key-vault-name" {
    type = string
    default = "kv-mf-dev-01"
}

variable "function-storage-name" {
    type = string
    default = "samffundev01"
}

variable "aks-cluster-name" {
  type = string
  default = "aks-mf-dev-01"
}
