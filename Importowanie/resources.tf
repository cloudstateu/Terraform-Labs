resource "azurerm_storage_account" "imported_storage" {
  name                     = "mz12teststorage"
  resource_group_name      = "LabResourceGroup"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}
