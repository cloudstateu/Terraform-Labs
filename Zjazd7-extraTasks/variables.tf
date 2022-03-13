#Should be overwritten by a safe password variable stored in a safe way (not in file) like local variables
variable "username" {
  type = string
  default = "admin1234"
}

#Should be overwritten by a safe password variable stored in a safe way (not in file) like local variables
variable "password" {
  type = string
  default = "Password1234"
}

variable "subscription_id" {
  type = string
  default = "07db2bf6-3a2c-49b9-bdd4-6f6c43d02339"
}