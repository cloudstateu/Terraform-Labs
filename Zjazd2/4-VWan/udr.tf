resource "azurerm_route_table" "defaulttofirewall" {
  name                          = "routetofirewall"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  disable_bgp_route_propagation = false

  route {
    name           = "ToFirewall"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.vnet-hub-firewall.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "hub-to-firewall-table-associate" {
  subnet_id      = azurerm_subnet.vnet-hub-vm-subnet.id
  route_table_id = azurerm_route_table.defaulttofirewall.id
}