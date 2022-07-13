data "azurerm_resource_group" "rg" {
  name = "" # TODO Resource group name
}

data "azurerm_client_config" "current" {}
