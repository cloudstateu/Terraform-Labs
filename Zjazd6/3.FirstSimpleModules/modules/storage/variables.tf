variable "sa-name" {
    type = string
    description = "Name of storage account"
}

variable "rg-name" {
    type = string
    description = "Name of resource group"
}

variable "sa-location" {
    type = string
    description = "Azure location of storage account environment"
    default = "westeurope"
}

// variable "storage_account_object" {
//     description = "Storage Account Object Parameters"
//     type                              = object({
//             sa_name                       = string
//             rg_name                       = string
//     })
// }
