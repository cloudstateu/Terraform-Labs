# Create public IPs for hub vm
resource "azurerm_public_ip" "hub-vm-public-ip" {
    name                         = "hub-vm-public-ip"
    location                     = data.azurerm_resource_group.main_rg.location
    resource_group_name          = data.azurerm_resource_group.main_rg.name
    allocation_method            = "Dynamic"
}

# Create Network Security Group and rule for hub vm
resource "azurerm_network_security_group" "hub-vm-nsg" {
    name                = "hub-vm-nsg"
    location                     = data.azurerm_resource_group.main_rg.location
    resource_group_name          = data.azurerm_resource_group.main_rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

# Create network interface for hub vm
resource "azurerm_network_interface" "hub-vm-nic" {
    name                      = "hub-vm-nic"
    location                     = data.azurerm_resource_group.main_rg.location
    resource_group_name          = data.azurerm_resource_group.main_rg.name

    ip_configuration {
        name                          = "hubvmnicconfig"
        subnet_id                     = azurerm_subnet.vnet-hub-vm-subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.hub-vm-public-ip.id
    }
}

# Connect the security group to the network interface for hub vm
resource "azurerm_network_interface_security_group_association" "hubnsg" {
    network_interface_id      = azurerm_network_interface.hub-vm-nic.id
    network_security_group_id = azurerm_network_security_group.hub-vm-nsg.id
}

# Create hub VM
resource "azurerm_virtual_machine" "hub-vnet-vm" {
  name                  = "hub-vnet-vm"
  location                     = data.azurerm_resource_group.main_rg.location
  resource_group_name          = data.azurerm_resource_group.main_rg.name
  network_interface_ids = [azurerm_network_interface.hub-vm-nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "hub-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hubvm"
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

