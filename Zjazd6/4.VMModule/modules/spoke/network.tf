resource "azurerm_virtual_network" "vnet-spoke" {
  provider            = azurerm.spoke
  name                = "vnet-spoke-${var.spoke_number}"
  location            = var.location
  resource_group_name = var.spoke_resource_group_name
  address_space       = var.address_prefix
}

resource "azurerm_subnet" "vnet-spoke-subnet" {
  provider = azurerm.spoke

  for_each = var.subnets

  name                 = "vnet-spoke-${var.spoke_number}-subnet-${each.value.name}"
  virtual_network_name = azurerm_virtual_network.vnet-spoke.name
  resource_group_name  = var.spoke_resource_group_name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_virtual_network_peering" "hub-to-spoke" {
  provider                     = azurerm.hub
  name                         = "hub-to-spoke-${var.spoke_number}"
  resource_group_name          = var.hub_resource_group_name
  virtual_network_name         = var.hub_virtual_network_name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke-to-hub" {
  provider                     = azurerm.spoke
  name                         = "spoke-${var.spoke_number}-to-hub"
  resource_group_name          = var.spoke_resource_group_name
  virtual_network_name         = azurerm_virtual_network.vnet-spoke.name
  remote_virtual_network_id    = var.hub_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
