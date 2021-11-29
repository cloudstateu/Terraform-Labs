resource "azurerm_virtual_network" "vnet-dev-10-100-0-0--16" {
  name                = "vnet-dev-10-100-0-0--16"
  location            = azurerm_resource_group.dev-net-rg.location
  resource_group_name = azurerm_resource_group.dev-net-rg.name
  address_space       = var.vnet-dev

  #dns, ktory nie istnieje
  dns_servers = ["10.10.2.4"]

  tags = {
    "Project"     = "HUB VNET"
    "Description" = "HUB NETWORK FOR DC-CLOUD CONNECTIVITY"
  }
}

resource "azurerm_subnet" "subnet-frontend" {
  count                = var.number-of-net
  name                 = "subnet-frontend-${count.index}-10-100-${count.index * 4}-0--24"
  resource_group_name  = azurerm_resource_group.dev-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-dev-10-100-0-0--16.name
  address_prefixes     = ["10.100.${count.index * 4}.0/24"]
  //enforce_private_link_endpoint_network_policies = false

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "subnet-backend" {
  count                = var.number-of-net
  name                 = "subnet-backend-${count.index}-10-100-${count.index * 4 + 1}-0--24"
  resource_group_name  = azurerm_resource_group.dev-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-dev-10-100-0-0--16.name
  address_prefixes     = ["10.100.${count.index * 4 + 1}.0/24"]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "subnet-data" {
  count                = var.number-of-net
  name                 = "subnet-data-${count.index}-10-100-${count.index * 4 + 2}-0--24"
  resource_group_name  = azurerm_resource_group.dev-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-dev-10-100-0-0--16.name
  address_prefixes     = ["10.100.${count.index * 4 + 2}.0/24"]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "subnet-dedicated" {
  count                = var.number-of-net
  name                 = "subnet-data-${count.index}-10-100-${count.index * 4 + 3}-0--24"
  resource_group_name  = azurerm_resource_group.dev-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-dev-10-100-0-0--16.name
  address_prefixes     = ["10.100.${count.index * 4 + 3}.0/24"]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}


resource "azurerm_subnet_network_security_group_association" "subnet-frontend-nsg-association" {
  count                     = var.number-of-net
  subnet_id                 = azurerm_subnet.subnet-frontend[count.index].id
  network_security_group_id = azurerm_network_security_group.NSG-FRONTEND[count.index].id
}


resource "azurerm_subnet_network_security_group_association" "subnet-backend-nsg-association" {
  count                     = var.number-of-net
  subnet_id                 = azurerm_subnet.subnet-backend[count.index].id
  network_security_group_id = azurerm_network_security_group.NSG-BACKEND[count.index].id

}

resource "azurerm_subnet_network_security_group_association" "subnet-data-nsg-association" {
  count                     = var.number-of-net
  subnet_id                 = azurerm_subnet.subnet-data[count.index].id
  network_security_group_id = azurerm_network_security_group.NSG-DATA[count.index].id
}

resource "azurerm_subnet_network_security_group_association" "subnet-dedicated-nsg-association" {
  count                     = var.number-of-net
  subnet_id                 = azurerm_subnet.subnet-dedicated[count.index].id
  network_security_group_id = azurerm_network_security_group.NSG-DEDICATED[count.index].id
}

