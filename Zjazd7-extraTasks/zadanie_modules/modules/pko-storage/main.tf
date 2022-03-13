data "azurerm_resource_group" "current" {
  name = var.storage-account-rg
}


resource "azurerm_storage_account" "current" {
  account_replication_type = var.storage-account-replication
  account_tier             = "Standard"
  location                 = data.azurerm_resource_group.current.location
  resource_group_name      = data.azurerm_resource_group.current.name
  name                     = var.storage-account-name
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = "false"
  blob_properties {
    delete_retention_policy {
      days = 5
    }
  }
}