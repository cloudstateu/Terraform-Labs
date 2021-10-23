resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vnet-hub-private-app-service-subnet" {
  name                                           = "app-service-subnet"
  virtual_network_name                           = azurerm_virtual_network.vnet-hub.name
  resource_group_name                            = azurerm_resource_group.main_rg.name
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = false
  address_prefixes                               = ["10.0.0.0/24"]
}


resource "azurerm_subnet" "vnet-hub-private-cosmodb-subnet" {
  name                                           = "cosmosdb-subnet"
  virtual_network_name                           = azurerm_virtual_network.vnet-hub.name
  resource_group_name                            = azurerm_resource_group.main_rg.name
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = false
  address_prefixes                               = ["10.0.1.0/24"]
}


resource "azurerm_subnet" "vnet-hub-private-function-subnet" {
  name                                           = "function-subnet"
  virtual_network_name                           = azurerm_virtual_network.vnet-hub.name
  resource_group_name                            = azurerm_resource_group.main_rg.name
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = false
  address_prefixes                               = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "vnet-hub-private-vm-subnet" {
  name                                           = "vm-subnet"
  virtual_network_name                           = azurerm_virtual_network.vnet-hub.name
  resource_group_name                            = azurerm_resource_group.main_rg.name
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = false
  address_prefixes                               = ["10.0.3.0/24"]
}