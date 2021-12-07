
resource "azurerm_public_ip" "pip-vm01" {
  name                = "pip-vm01"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location
  allocation_method   = "Dynamic"

}

output "pip-vm01-value" {
  value = azurerm_public_ip.pip-vm01.ip_address
}

resource "azurerm_network_interface" "nic-vm01" {
  name                = "nic-vm01"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location

  ip_configuration {
    name                          = "nic-vm01-ipconfig01"
    subnet_id                     = azurerm_subnet.hub-vnet01-subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-vm01.id
  }
}

resource "azurerm_linux_virtual_machine" "vm01" {
  name                = "vm01"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location
  size                = "Standard_B1s"

  disable_password_authentication = false
  admin_username                  = "adminuser"
  admin_password                  = "Testtest123!@#"

  network_interface_ids = [
    azurerm_network_interface.nic-vm01.id,
  ]

  os_disk {
    name                 = "vm01-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

########## VM02

variable "vmnameprefix" {
  default = "vm02"
}

resource "azurerm_network_interface" "nic-vm02" {
  name                = "nic-${var.vmnameprefix}"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location

  ip_configuration {
    name                          = "nic-${var.vmnameprefix}-ipconfig01"
    subnet_id                     = azurerm_subnet.spoke-vnet02-subnet01.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm02" {
  name                = var.vmnameprefix
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location
  size                = "Standard_B1s"

  disable_password_authentication = false
  admin_username                  = "adminuser"
  admin_password                  = "Testtest123!@#"

  network_interface_ids = [
    azurerm_network_interface.nic-vm02.id,
  ]

  os_disk {
    name                 = "${var.vmnameprefix}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}