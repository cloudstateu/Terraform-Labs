resource "azurerm_storage_account" "storage" {
  name                     = var.storage_name
  resource_group_name      = var.storage_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}