resource "azurerm_storage_account" "example" {
  name                     = "mz12teststorage"
  resource_group_name      = "LabResourceGroup"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
