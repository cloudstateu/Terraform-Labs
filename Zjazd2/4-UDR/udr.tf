resource "azurerm_route_table" "spoke-01-rt" {
  name                          = "spoke-01-rt"
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

resource "azurerm_subnet_route_table_association" "spoke-01-to-firewall-table-associate" {
  subnet_id      = azurerm_subnet.vnet-spoke-01-vm-subnet.id
  route_table_id = azurerm_route_table.spoke-01-rt.id
}

resource "azurerm_route_table" "spoke-02-rt" {
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

resource "azurerm_subnet_route_table_association" "spoke-02-to-firewall-table-associate" {
  subnet_id      = azurerm_subnet.vnet-spoke-02-vm-subnet.id
  route_table_id = azurerm_route_table.spoke-02-rt.id
}
