resource "azurerm_virtual_network" "vnet-hub" {
  provider            = azurerm.hub
  name                = "vnet-hub"
  location            = data.azurerm_resource_group.hub_rg.location
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "vnet-spoke-01" {
  provider            = azurerm.spoke
  name                = "vnet-spoke-01"
  location            = data.azurerm_resource_group.spoke_rg.location
  resource_group_name = data.azurerm_resource_group.spoke_rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network" "vnet-spoke-02" {
  provider            = azurerm.spoke
  name                = "vnet-spoke-02"
  location            = data.azurerm_resource_group.spoke_rg.location
  resource_group_name = data.azurerm_resource_group.spoke_rg.name
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "vnet-hub-firewall-subnet" {
  provider             = azurerm.hub
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  resource_group_name  = data.azurerm_resource_group.hub_rg.name
  address_prefixes     = ["10.0.0.0/26"]
}

resource "azurerm_subnet" "vnet-spoke-01-vm-subnet" {
  provider             = azurerm.spoke
  name                 = "vm-subnet"
  virtual_network_name = azurerm_virtual_network.vnet-spoke-01.name
  resource_group_name  = data.azurerm_resource_group.spoke_rg.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_subnet" "vnet-spoke-02-vm-subnet" {
  provider             = azurerm.spoke
  name                 = "vm-subnet"
  virtual_network_name = azurerm_virtual_network.vnet-spoke-02.name
  resource_group_name  = data.azurerm_resource_group.spoke_rg.name
  address_prefixes     = ["10.2.0.0/24"]
}

resource "azurerm_virtual_network_peering" "vnet-hub-to-spoke-01-peering" {
  provider                     = azurerm.hub
  name                         = "hub-to-spoke-01"
  resource_group_name          = data.azurerm_resource_group.hub_rg.name
  virtual_network_name         = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-spoke-01.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vnet-spoke-01-to-hub-peering" {
  provider                     = azurerm.spoke
  name                         = "spoke-01-to-hub"
  resource_group_name          = data.azurerm_resource_group.spoke_rg.name
  virtual_network_name         = azurerm_virtual_network.vnet-spoke-01.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vnet-hub-to-spoke-02-peering" {
  provider                     = azurerm.hub
  name                         = "hub-to-spoke-02"
  resource_group_name          = data.azurerm_resource_group.hub_rg.name
  virtual_network_name         = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-spoke-02.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vnet-spoke-02-to-hub-peering" {
  provider                     = azurerm.spoke
  name                         = "spoke-02-to-hub"
  resource_group_name          = data.azurerm_resource_group.spoke_rg.name
  virtual_network_name         = azurerm_virtual_network.vnet-spoke-02.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
