output "storage-account-name" {
  value = azurerm_storage_account.current.name
}

output "location" {
  value = data.azurerm_resource_group.current.location
}

output "resource-group-name" {
  value = data.azurerm_resource_group.current.name
}