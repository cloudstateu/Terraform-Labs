variable "storage-account-name" {
  description = "Name of the storage account"

  validation {
    condition     = length(var.storage-account-name) < 19
    error_message = "Name cannot be longer than 19 characters."
  }
}

variable "storage-account-rg" {
  description = "Name of the Resource Group to which storage account will be deployed"
}

variable "storage-account-replication" {
  description = "Replication class of the storage account"

  validation {
    condition = contains(["GRS", "RAGRS"],var.storage-account-replication)
    error_message = "Allowed Replication Classes are: GRS, RAGRS."
  }
}
