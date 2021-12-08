
#TODO - uwaga na adresy IP
resource "azurerm_network_security_group" "nsg-subnet01-hub-vnet01" {
  depends_on = [
    azurerm_public_ip.pip-vm01,
    azurerm_linux_virtual_machine.vm01
  ]
  name                = "nsg-subnet01-hub-vnet01"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location

  security_rule {
    name                       = "allow_ssh_fromhome"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    ## TODO - ustawi adres ip swojej maszyny
    destination_address_prefix = azurerm_public_ip.pip-vm01.ip_address
  }

  # security_rule {
  #   name                       = "blockall"
  #   priority                   = 4096
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
}

resource "azurerm_subnet_network_security_group_association" "nsg-subnet01-hub-vnet01-assocation" {
  subnet_id                 = azurerm_subnet.hub-vnet01-subnet01.id
  network_security_group_id = azurerm_network_security_group.nsg-subnet01-hub-vnet01.id
}