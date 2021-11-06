resource "azurerm_route_table" "subnet-frontend-0-10-100-0-0--24-RT" {
  name                          = "subnet-frontend-0-10-100-0-0--24-RT"
  location                      = azurerm_resource_group.dev-net-rg.location
  resource_group_name           = azurerm_resource_group.dev-net-rg.name
  disable_bgp_route_propagation = false
}

resource "azurerm_route" "subnet-frontend-0-10-100-0-0--24-RT-INTERNET" {
  depends_on = [
    azurerm_firewall.fw01
  ]
  name                   = "Internet"
  resource_group_name    = azurerm_resource_group.dev-net-rg.name
  route_table_name       = azurerm_route_table.subnet-frontend-0-10-100-0-0--24-RT.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.fw01.ip_configuration[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "subnet-frontend-0-10-100-0-0--24-RT-ASC" {
  subnet_id      = azurerm_subnet.subnet-frontend[0].id
  route_table_id = azurerm_route_table.subnet-frontend-0-10-100-0-0--24-RT.id
}