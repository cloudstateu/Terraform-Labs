# Create Network Security Group and rule for spoke vm
resource "azurerm_network_security_group" "spoke-vm-nsg" {
    name                = "spoke-vm-nsg"
    location                     = data.azurerm_resource_group.main_rg.location
    resource_group_name          = data.azurerm_resource_group.main_rg.name
}

# Create network interface for spoke vm
resource "azurerm_network_interface" "spoke-vm-nic" {
    name                      = "spoke-vm-nic"
    location                     = data.azurerm_resource_group.main_rg.location
    resource_group_name          = data.azurerm_resource_group.main_rg.name

    ip_configuration {
        name                          = "spokevmnicconfig"
        subnet_id                     = azurerm_subnet.vnet-spoke-vm-subnet.id
        private_ip_address_allocation = "Dynamic"
    }
}

# Connect the security group to the network interface for spoke vm
resource "azurerm_network_interface_security_group_association" "spokensg" {
    network_interface_id      = azurerm_network_interface.spoke-vm-nic.id
    network_security_group_id = azurerm_network_security_group.spoke-vm-nsg.id
}

# Create spoke VM
resource "azurerm_virtual_machine" "spoke-vnet-vm" {
  name                  = "spoke-vnet-vm"
  location                     = data.azurerm_resource_group.main_rg.location
  resource_group_name          = data.azurerm_resource_group.main_rg.name
  network_interface_ids = [azurerm_network_interface.spoke-vm-nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "spoke-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "spokevm"
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

