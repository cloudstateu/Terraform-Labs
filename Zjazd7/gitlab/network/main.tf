resource "azurerm_resource_group" "rg" {
  name     = "hub-rg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vnet-hub-vm-subnet" {
  name                 = "vm-subnet"
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_virtual_network" "vnet-spoke" {
  name                = "vnet-spoke"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vnet-spoke-vm-subnet" {
  name                 = "vm-subnet"
  virtual_network_name = azurerm_virtual_network.vnet-spoke.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_virtual_network_peering" "vnet-hub-to-spoke-peering" {
  name                      = "hub-to-spoke"
  resource_group_name       = azurerm_virtual_network.vnet-hub.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-spoke.id
}

resource "azurerm_virtual_network_peering" "vnet-spoke-to-hub-peering" {
  name                      = "spoke-to-hub"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet-spoke.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-hub.id
}
