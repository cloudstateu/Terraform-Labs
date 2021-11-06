resource "azurerm_virtual_network" "vnet-global" {
  name                = "vnet-global"
  location            = azurerm_resource_group.global-net-rg.location
  resource_group_name = azurerm_resource_group.global-net-rg.name
  address_space       = var.vnet-global

  #TODO
  #dns_servers = var.local-dns

  tags = {
    "Project"     = "GLOBAL VNET"
    "Description" = "GLOABL NETWORK"
  }
}

resource "azurerm_subnet" "vnet-global-azurefirewall-subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.global-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-global.name
  address_prefixes     = var.vnet-global-azurefirewall-subnet

}