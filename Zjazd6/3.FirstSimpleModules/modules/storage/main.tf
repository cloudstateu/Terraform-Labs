resource "azurerm_storage_account" "storageaccount" {
  name                     = var.sa-name
  resource_group_name      = var.rg-name
  location                 = var.sa-location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
}

