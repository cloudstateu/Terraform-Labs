resource "azurerm_network_security_group" "nsg-subnet01-hub-vnet01" {
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
    source_address_prefix      = "158.101.220.127"
    destination_address_prefix = "40.115.45.51"
  }

  security_rule {
    name                       = "blockall"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-subnet01-hub-vnet01-assocation" {
  subnet_id                 = azurerm_subnet.hub-vnet01-subnet01.id
  network_security_group_id = azurerm_network_security_group.nsg-subnet01-hub-vnet01.id
}