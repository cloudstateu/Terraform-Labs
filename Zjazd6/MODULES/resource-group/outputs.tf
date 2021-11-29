output "id" {
  value       = azurerm_resource_group.ab_resource_group.id
  description = "Resource Group ID"
}

output "name" {
  value       = azurerm_resource_group.ab_resource_group.name
  description = "Nazwa Resource Group"
}

output "location" {
  value       = azurerm_resource_group.ab_resource_group.location
  description = "Region Resource Group"
}