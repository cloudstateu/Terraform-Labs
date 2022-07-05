# Create Network Security Group and rule for spoke-02 vm
resource "azurerm_network_security_group" "spoke-02-vm-nsg" {
  name                = "spoke-02-vm-nsg"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
}

# Create network interface for spoke-02 vm
resource "azurerm_network_interface" "spoke-02-vm-nic" {
  name                = "spoke-02-vm-nic"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "spoke-02vmnicconfig"
    subnet_id                     = azurerm_subnet.vnet-spoke-02-vm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Connect the security group to the network interface for spoke-02 vm
resource "azurerm_network_interface_security_group_association" "spoke-02nsg" {
  network_interface_id      = azurerm_network_interface.spoke-02-vm-nic.id
  network_security_group_id = azurerm_network_security_group.spoke-02-vm-nsg.id
}

# Create spoke-02 VM
resource "azurerm_virtual_machine" "spoke-02-vnet-vm" {
  name                  = "spoke-02-vnet-vm"
  location              = data.azurerm_resource_group.main_rg.location
  resource_group_name   = data.azurerm_resource_group.main_rg.name
  network_interface_ids = [azurerm_network_interface.spoke-02-vm-nic.id]
  vm_size               = "Standard_D2as_v5"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "spoke-02-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "spoke02vm"
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

