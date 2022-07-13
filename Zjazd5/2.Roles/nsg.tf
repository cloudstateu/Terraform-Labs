resource "azurerm_network_security_group" "nsg" {
  name                = local.nsg_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}