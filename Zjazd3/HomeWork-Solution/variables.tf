variable "sub-id" {
  type = string
  #TODO: mifurm, zmieniam na SUB-10
  default = "c6484eee-b936-412a-94d6-8dc1b4386bc2"
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