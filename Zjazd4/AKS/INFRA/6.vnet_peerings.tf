resource "azurerm_virtual_network_peering" "vnet-hub-to-vnet-global-peering" {
  name                      = "vnet-hub-to-vnet-global-peering"
  resource_group_name       = azurerm_resource_group.hub-net-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-global.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  allow_gateway_transit     = false

}

resource "azurerm_virtual_network_peering" "vnet-global-to-vnet-hub-peering" {
  name                      = "vnet-global-to-vnet-hub-peering"
  resource_group_name       = azurerm_resource_group.global-net-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet-global.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-hub.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  allow_gateway_transit     = false
}

resource "azurerm_virtual_network_peering" "vnet-dev-to-vnet-global-peering" {
  name                      = "vnet-dev-to-vnet-global-peering"
  resource_group_name       = azurerm_resource_group.dev-net-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet-dev-10-100-0-0--16.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-global.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  allow_gateway_transit     = false
}

resource "azurerm_virtual_network_peering" "vnet-global-to-vnet-dev-peering" {
  name                      = "vnet-global-to-vnet-dev-peering"
  resource_group_name       = azurerm_resource_group.global-net-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet-global.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-dev-10-100-0-0--16.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  allow_gateway_transit     = false
}

resource "azurerm_virtual_network_peering" "vnet-dev-to-vnet-hub-peering" {
  name                      = "vnet-dev-to-vnet-hub-peering"
  resource_group_name       = azurerm_resource_group.dev-net-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet-dev-10-100-0-0--16.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-hub.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  allow_gateway_transit     = false
}

resource "azurerm_virtual_network_peering" "vnet-hub-to-vnet-dev-peering" {
  name                      = "vnet-hub-to-vnet-dev-peering"
  resource_group_name       = azurerm_resource_group.hub-net-rg.name
  virtual_network_name      = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-dev-10-100-0-0--16.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  allow_gateway_transit     = false
}
 