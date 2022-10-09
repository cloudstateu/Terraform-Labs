# Create Network Security Group and rule for spoke-02 vm
resource "azurerm_network_security_group" "spoke_02_vm_nsg" {
  name                = "spoke-02-vm-nsg"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
}

# Create network interface for spoke-02 vm
resource "azurerm_network_interface" "spoke_02_vm_nic" {
  name                = "spoke-02-vm-nic"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "spoke-02vmnicconfig"
    subnet_id                     = azurerm_subnet.vnet_spoke_02_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Connect the security group to the network interface for spoke-02 vm
resource "azurerm_network_interface_security_group_association" "spoke_02nsg" {
  network_interface_id      = azurerm_network_interface.spoke_02_vm_nic.id
  network_security_group_id = azurerm_network_security_group.spoke_02_vm_nsg.id
}

# Create spoke-02 VM
resource "azurerm_linux_virtual_machine" "spoke_02_vnet_vm" {
  name                            = "spoke-02-vnet-vm"
  location                        = data.azurerm_resource_group.main_rg.location
  resource_group_name             = data.azurerm_resource_group.main_rg.name
  network_interface_ids           = [azurerm_network_interface.spoke_02_vm_nic.id]
  size                            = "Standard_D2as_v5"
  disable_password_authentication = false
  admin_username                  = var.username
  admin_password                  = var.password
  computer_name                   = "spoke2"

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
