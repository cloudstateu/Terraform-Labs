output "virtual_network_id" {
  value = azurerm_virtual_network.vnet-spoke.id
}

output "subnets" {
  value = azurerm_subnet.vnet-spoke-subnet
}
