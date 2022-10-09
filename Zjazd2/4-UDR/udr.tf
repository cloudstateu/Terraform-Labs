resource "azurerm_route_table" "spoke_01_rt" {
  name                          = "spoke_01_rt"
  location                      = data.azurerm_resource_group.main_rg.location
  resource_group_name           = data.azurerm_resource_group.main_rg.name
  disable_bgp_route_propagation = false

  route {
    name                   = "toSpoke2"
    address_prefix         = "10.2.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "spoke_01_to_firewall_table_associate" {
  subnet_id      = azurerm_subnet.vnet_spoke_01_vm_subnet.id
  route_table_id = azurerm_route_table.spoke_01_rt.id
}

resource "azurerm_route_table" "spoke_02_rt" {
  name                          = "spoke-02-rt"
  location                      = data.azurerm_resource_group.main_rg.location
  resource_group_name           = data.azurerm_resource_group.main_rg.name
  disable_bgp_route_propagation = false

  route {
    name                   = "toSpoke1"
    address_prefix         = "10.1.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "spoke_02_to_firewall_table_associate" {
  subnet_id      = azurerm_subnet.vnet_spoke_02_vm_subnet.id
  route_table_id = azurerm_route_table.spoke_02_rt.id
}
