resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.homework-rg.location
  resource_group_name = azurerm_resource_group.homework-rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vnet-hub-private-subnet" {
  name                                           = "vnet-hub-private-subnet"
  virtual_network_name                           = azurerm_virtual_network.vnet-hub.name
  resource_group_name                            = azurerm_resource_group.homework-rg.name
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = false
  address_prefixes                               = ["10.0.0.0/24"]
}