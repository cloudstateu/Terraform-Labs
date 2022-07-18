output "virtual_machine_id" {
    value = azurerm_linux_virtual_machine.vnet-vm.id
}

output "vm-public-ip" {
    value = azurerm_linux_virtual_machine.vnet-vm.public_ip_address
}

output "vm-private-ip" {
    value = azurerm_linux_virtual_machine.vnet-vm.private_ip_address
}