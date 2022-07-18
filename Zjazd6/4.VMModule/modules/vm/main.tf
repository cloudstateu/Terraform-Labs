resource "azurerm_public_ip" "vm-public-ip" {
  provider = azurerm.virtual-machine

  count = var.use_public_ip == true ? 1 : 0

  name                = "${var.virtual_machine_name}-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

# Create network interface for spoke vm
resource "azurerm_network_interface" "vm-nic" {
  provider = azurerm.virtual-machine

  name                = "${var.virtual_machine_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.virtual_machine_name}-nic-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.use_public_ip == true ? azurerm_public_ip.vm-public-ip[0].id : null
  }
}

resource "azurerm_linux_virtual_machine" "vnet-vm" {
  provider = azurerm.virtual-machine

  name                            = var.virtual_machine_name
  computer_name                   = var.virtual_machine_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.vm-nic.id]
  size                            = "Standard_D2as_v5"
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  source_image_reference {
    publisher = var.source_image.publisher
    offer     = var.source_image.offer
    sku       = var.source_image.sku
    version   = var.source_image.version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

