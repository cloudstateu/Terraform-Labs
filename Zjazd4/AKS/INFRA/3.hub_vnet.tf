resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.hub-net-rg.location
  resource_group_name = azurerm_resource_group.hub-net-rg.name
  address_space       = var.vnet-hub

  dns_servers = ["10.10.2.4"]

  #TODO - LOCAL DNS SERVERS

  tags = {
    "Project"     = "HUB VNET"
    "Description" = "HUB NETWORK FOR DC-CLOUD CONNECTIVITY"
  }
}

# resource "azurerm_subnet" "vnet-hub-gatewaysubnet" {
#   name                 = "GatewaySubnet"
#   virtual_network_name = azurerm_virtual_network.vnet-hub.name
#   resource_group_name  = azurerm_resource_group.hub-net-rg.name
#   address_prefixes     = var.vnet-hub-gatewaysubnet
# }

resource "azurerm_subnet" "vnet-hub-subnet" {
  name                 = "vnet-hub-subnet"
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  resource_group_name  = azurerm_resource_group.hub-net-rg.name
  address_prefixes     = var.vnet-hub-gatewaysubnet
}

resource "azurerm_subnet" "AzureFirewallSubnet" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  resource_group_name  = azurerm_resource_group.hub-net-rg.name
  address_prefixes     = ["10.10.2.0/26"]
}