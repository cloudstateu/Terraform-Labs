resource "azurerm_virtual_network" "vnet_hub" {
  provider            = azurerm.hub
  name                = "vnet-hub"
  location            = data.azurerm_resource_group.hub.location
  resource_group_name = data.azurerm_resource_group.hub.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "vnet_spoke_01" {
  provider            = azurerm.spoke
  name                = "vnet-spoke-01"
  location            = data.azurerm_resource_group.spoke.location
  resource_group_name = data.azurerm_resource_group.spoke.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network" "vnet_spoke_02" {
  provider            = azurerm.spoke
  name                = "vnet-spoke-02"
  location            = data.azurerm_resource_group.spoke.location
  resource_group_name = data.azurerm_resource_group.spoke.name
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "vnet_hub_firewall_subnet" {
  provider             = azurerm.hub
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  resource_group_name  = data.azurerm_resource_group.hub.name
  address_prefixes     = ["10.0.0.0/26"]
}

resource "azurerm_subnet" "vnet_spoke_01_vm_subnet" {
  provider             = azurerm.spoke
  name                 = "vm-subnet"
  virtual_network_name = azurerm_virtual_network.vnet_spoke_01.name
  resource_group_name  = data.azurerm_resource_group.spoke.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_subnet" "vnet_spoke_02_vm_subnet" {
  provider             = azurerm.spoke
  name                 = "vm-subnet"
  virtual_network_name = azurerm_virtual_network.vnet_spoke_02.name
  resource_group_name  = data.azurerm_resource_group.spoke.name
  address_prefixes     = ["10.2.0.0/24"]
}

resource "azurerm_virtual_network_peering" "vnet_hub_to_spoke_01_peering" {
  provider                     = azurerm.hub
  name                         = "hub-to-spoke-01"
  resource_group_name          = data.azurerm_resource_group.hub.name
  virtual_network_name         = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_spoke_01.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vnet_spoke_01_to_hub_peering" {
  provider                     = azurerm.spoke
  name                         = "spoke-01-to-hub"
  resource_group_name          = data.azurerm_resource_group.spoke.name
  virtual_network_name         = azurerm_virtual_network.vnet_spoke_01.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vnet_hub_to_spoke_02_peering" {
  provider                     = azurerm.hub
  name                         = "hub-to-spoke-02"
  resource_group_name          = data.azurerm_resource_group.hub.name
  virtual_network_name         = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_spoke_02.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vnet_spoke_02_to_hub_peering" {
  provider                     = azurerm.spoke
  name                         = "spoke-02-to-hub"
  resource_group_name          = data.azurerm_resource_group.spoke.name
  virtual_network_name         = azurerm_virtual_network.vnet_spoke_02.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
