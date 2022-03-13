output "id" {
    value       = azurerm_virtual_network.ab_virtual_network.id
    description = "Virtual Network ID"
}

output "name" {
    value       = azurerm_virtual_network.ab_virtual_network.name
    description = "Nazwa Virtual Network"
}

output "location" {
    value       = azurerm_virtual_network.ab_virtual_network.location
    description = "Region Virtual Network"
}

output "address_space" {
    value       = azurerm_virtual_network.ab_virtual_network.address_space
    description = "Adresacja Virtual Network"
}