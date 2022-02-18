resource "azurerm_resource_group" "rg" {
  name     = "rg-jenkins"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-jenkins"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "jenkins_vnet_subnet" {
  name                 = "vnet-jenkins-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "ip" {
  name                = "pip-jenkins"
  allocation_method   = "Static"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-jenkins"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-jenkins-ip-config"
    subnet_id                     = azurerm_subnet.jenkins_vnet_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip.id
  }
}

resource "random_password" "password" {
  length  = 16
  special = true
}

resource "azurerm_linux_virtual_machine" "jenkins-vm" {
  name                            = "vm-jenkins"
  admin_username                  = "azureuser"
  admin_password                  = random_password.password.result
  disable_password_authentication = false
  location                        = azurerm_resource_group.rg.location
  network_interface_ids           = [
    azurerm_network_interface.nic.id,
  ]
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2s"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  custom_data = filebase64("init-jenkins.txt")

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

