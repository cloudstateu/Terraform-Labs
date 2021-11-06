resource "azurerm_network_security_group" "NSG-FRONTEND" {
  count               = var.number-of-net
  name                = "NSG-SUBNET-FRONTEND-${count.index}-10-100-${count.index * 4}-0--24"
  location            = azurerm_resource_group.dev-net-rg.location
  resource_group_name = azurerm_resource_group.dev-net-rg.name


  security_rule {
    name                       = "AllowAll_Inbound"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAll_Outbound"
    priority                   = 4095
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "Project"     = "HUB VNET"
    "Description" = "NSG FOR SUBNET FRONTEND"
  }
}

resource "azurerm_network_security_group" "NSG-BACKEND" {
  count               = var.number-of-net
  name                = "NSG-SUBNET-BACKEND-${count.index}-10-100-${count.index * 4 + 1}-0--24"
  location            = azurerm_resource_group.dev-net-rg.location
  resource_group_name = azurerm_resource_group.dev-net-rg.name


  security_rule {
    name                       = "AllowAll_Inbound"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAll_Outbound"
    priority                   = 4095
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "Project"     = "HUB VNET"
    "Description" = "NSG FOR SUBNET BACKEND"
  }
}

resource "azurerm_network_security_group" "NSG-DATA" {
  count               = var.number-of-net
  name                = "NSG-SUBNET-DATA-${count.index}-10-100-${count.index * 4 + 2}-0--24"
  location            = azurerm_resource_group.dev-net-rg.location
  resource_group_name = azurerm_resource_group.dev-net-rg.name


  security_rule {
    name                       = "AllowAll_Inbound"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAll_Outbound"
    priority                   = 4095
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "Project"     = "HUB VNET"
    "Description" = "NSG FOR SUBNET DATA"
  }
}

resource "azurerm_network_security_group" "NSG-DEDICATED" {
  count               = var.number-of-net
  name                = "NSG-SUBNET-DEDICATED-${count.index}-10-100-${count.index * 4 + 3}-0--24"
  location            = azurerm_resource_group.dev-net-rg.location
  resource_group_name = azurerm_resource_group.dev-net-rg.name


  security_rule {
    name                       = "AllowAll_Inbound"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAll_Outbound"
    priority                   = 4095
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "Project"     = "HUB VNET"
    "Description" = "NSG FOR SUBNET DEDICATED"
  }
}