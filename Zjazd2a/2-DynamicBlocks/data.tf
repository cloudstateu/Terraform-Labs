data "azurerm_resource_group" "main_rg" {
  name = "bank-student0" # TODO Resource group name
}

data "azurerm_monitor_diagnostic_categories" "categories" {
  resource_id = azurerm_storage_account.sa.id
}
