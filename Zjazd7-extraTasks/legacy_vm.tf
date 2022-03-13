# Create Network Security Group and rule for spoke vm
resource "azurerm_network_security_group" "legacy-vm-nsg" {
    name                = "legacy-vm-nsg"
    location                     = azurerm_resource_group.legacy_rg.location
    resource_group_name          = azurerm_resource_group.legacy_rg.name
}

# Create network interface for spoke vm
resource "azurerm_network_interface" "legacy-vm1-nic" {
    name                      = "legacy-vm1-nic"
    location                     = azurerm_resource_group.legacy_rg.location
    resource_group_name          = azurerm_resource_group.legacy_rg.name

    ip_configuration {
        name                          = "legacyvm1nicconfig"
        subnet_id                     = azurerm_subnet.legacy-sub.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_subnet_network_security_group_association" "legacynsg" {
  network_security_group_id = azurerm_network_security_group.legacy-vm-nsg.id
  subnet_id                 = azurerm_subnet.legacy-sub.id
}

# Create spoke VM1
resource "azurerm_virtual_machine" "legacy-vm1" {
  name                  = "legacy-vm1"
  location                     = azurerm_resource_group.legacy_rg.location
  resource_group_name          = azurerm_resource_group.legacy_rg.name
  network_interface_ids = [azurerm_network_interface.legacy-vm1-nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "legac-vm1-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "legacy-vm1"
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_lb" "legacy-vm-lb" {
  name                         = "legacy-vm-lb"
  location                     = azurerm_resource_group.legacy_rg.location
  resource_group_name          = azurerm_resource_group.legacy_rg.name
  sku                          = "Standard" # required for having backend pools
  frontend_ip_configuration {
    name                 = "legacy-vm-lb-frontend-ip"
    subnet_id            = azurerm_subnet.legacy-sub.id
    private_ip_address_allocation = "Static"
    private_ip_address   = "10.0.2.16"
  }
}

resource "azurerm_lb_backend_address_pool" "legacy-vm-lb_backendpool" {
  loadbalancer_id = azurerm_lb.legacy-vm-lb.id
  name            = "legacy-vm-lb_backendpool"
}


resource "azurerm_lb_backend_address_pool_address" "lvlbad1" {
  name                    = "lvlbad1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.legacy-vm-lb_backendpool.id
  virtual_network_id      = azurerm_virtual_network.vnet1.id
  ip_address              = azurerm_network_interface.legacy-vm1-nic.private_ip_address
}
