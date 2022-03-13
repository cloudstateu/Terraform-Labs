output "name" {
  value       = azurerm_route_table.ab_route_table.name
  description = "Nazwa Route Table"
}

output "id" {
  value       = azurerm_route_table.ab_route_table.id
  description = "Route Table ID"
}