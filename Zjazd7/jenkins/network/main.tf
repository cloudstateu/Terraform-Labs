resource "azurerm_resource_group" "rg" {
  provider = azurerm.network
  name     = "rg-main"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  provider            = azurerm.network
  name                = "vnet-main"
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "sbn" {
  provider             = azurerm.network
  name                 = "sbn-main"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/21"]
}
