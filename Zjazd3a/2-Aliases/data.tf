data "azurerm_resource_group" "hub" {
  provider = azurerm.hub
  name     = "sm-student0" # TODO Resource group name
}

data "azurerm_resource_group" "spoke" {
  provider = azurerm.spoke
  name     = "sm-student0" # TODO Resource group name
}
