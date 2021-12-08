

#TODO - RG do zmiany
resource "azurerm_route_table" "rt-subnet01-hub-vnet01" {
  name                = "rt-subnet01-hub-vnet01"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location
}

resource "azurerm_route" "rtr-subnet01-hub-vnet01-to-subnet02-spoke-vnet02" {
  name                   = "rtr-subnet01-hub-vnet01-to-subnet02-spoke-vnet02"
  resource_group_name    = data.azurerm_resource_group.tf-st-rg60.name
  route_table_name       = azurerm_route_table.rt-subnet01-hub-vnet01.name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.fw01.ip_configuration[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "rt-subnet01-hub-vnet01-association" {
  subnet_id      = azurerm_subnet.hub-vnet01-subnet01.id
  route_table_id = azurerm_route_table.rt-subnet01-hub-vnet01.id
}