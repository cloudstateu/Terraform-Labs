resource "azurerm_storage_account" "example" {
  name                     = "mz12teststorage"
  resource_group_name      = data.azurerm_resource_group.main_rg.name
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
