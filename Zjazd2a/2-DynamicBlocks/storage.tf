resource "azurerm_storage_account" "sa" {
  name                     = "bankstudent0logs"
  resource_group_name      = data.azurerm_resource_group.main_rg.name
  location                 = data.azurerm_resource_group.main_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
