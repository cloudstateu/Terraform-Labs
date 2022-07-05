# Create public IPs for spoke-01 vm
resource "azurerm_public_ip" "spoke-01-vm-public-ip" {
  name                = "spoke-01-vm-public-ip"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule for spoke vm
resource "azurerm_network_security_group" "spoke-01-vm-nsg" {
  name                = "spoke-01-vm-nsg"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name

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

# Create network interface for spoke vm
resource "azurerm_network_interface" "spoke-01-vm-nic" {
  name                = "spoke-01-vm-nic"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "spoke01vmnicconfig"
    subnet_id                     = azurerm_subnet.vnet-spoke-01-vm-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.spoke-01-vm-public-ip.id
  }
}

# Connect the security group to the network interface for spoke vm
resource "azurerm_network_interface_security_group_association" "spokensg" {
  network_interface_id      = azurerm_network_interface.spoke-01-vm-nic.id
  network_security_group_id = azurerm_network_security_group.spoke-01-vm-nsg.id
}

# Create spoke VM
resource "azurerm_virtual_machine" "spoke-01-vnet-vm" {
  name                  = "spoke-vnet-vm"
  location              = data.azurerm_resource_group.main_rg.location
  resource_group_name   = data.azurerm_resource_group.main_rg.name
  network_interface_ids = [azurerm_network_interface.spoke-01-vm-nic.id]
  vm_size               = "Standard_D2as_v5"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "spoke-01-vm-disk"
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

