data "azurerm_resource_group" "hub_rg" {
  provider = azurerm.hub
  name     = var.hub_resource_group_name
}

data "azurerm_resource_group" "spoke_rg" {
  provider = azurerm.spoke
  name     = var.spoke_resource_group_name
}

