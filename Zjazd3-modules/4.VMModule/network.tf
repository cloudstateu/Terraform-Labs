resource "azurerm_virtual_network" "vnet-hub" {
  provider            = azurerm.hub
  name                = "vnet-hub"
  location            = data.azurerm_resource_group.hub_rg.location
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vnet-hub-firewall-subnet" {
  provider             = azurerm.hub
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  resource_group_name  = data.azurerm_resource_group.hub_rg.name
  address_prefixes     = ["10.0.0.0/26"]
}

module "vnet_spoke_01" {
  source = "./modules/spoke"
  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.spoke
  }

  address_prefix            = ["10.1.0.0/16"]
  hub_resource_group_name   = data.azurerm_resource_group.hub_rg.name
  hub_virtual_network_id    = azurerm_virtual_network.vnet-hub.id
  hub_virtual_network_name  = azurerm_virtual_network.vnet-hub.name
  location                  = data.azurerm_resource_group.spoke_rg.location
  spoke_number              = 1
  spoke_resource_group_name = data.azurerm_resource_group.spoke_rg.name
  subnets = {
    "vm" = {
      name             = "vm-app"
      address_prefixes = ["10.1.0.0/24"]
    }
  }
}

module "vnet_spoke_02" {
  source = "./modules/spoke"
  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.spoke
  }

  address_prefix            = ["10.2.0.0/16"]
  hub_resource_group_name   = data.azurerm_resource_group.hub_rg.name
  hub_virtual_network_id    = azurerm_virtual_network.vnet-hub.id
  hub_virtual_network_name  = azurerm_virtual_network.vnet-hub.name
  location                  = data.azurerm_resource_group.spoke_rg.location
  spoke_number              = 2
  spoke_resource_group_name = data.azurerm_resource_group.spoke_rg.name
  subnets = {
    "vm" = {
      name             = "vm-app"
      address_prefixes = ["10.2.0.0/24"]
    }
  }
}
