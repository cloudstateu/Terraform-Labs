output "name" {
  value       = azurerm_network_security_group.ab_network_security_group.name
  description = "Nazwa NSG"
}

output "id" {
  value       = azurerm_network_security_group.ab_network_security_group.id
  description = "NSG ID"
}