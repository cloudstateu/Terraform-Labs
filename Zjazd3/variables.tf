variable "sub-id" {
  type = string
  default = "ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
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