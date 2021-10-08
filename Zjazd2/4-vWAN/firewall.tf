resource "azurerm_subnet" "vnet-hub-firewall-subnet" {
    name                 = "AzureFirewallSubnet"
    virtual_network_name = azurerm_virtual_network.vnet-hub.name
    resource_group_name  = data.azurerm_resource_group.main_rg.name
    address_prefixes     = ["10.0.1.0/26"]
}

resource "azurerm_public_ip" "firewall-ip" {
  name                = "firewall-ip"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "vnet-hub-firewall" {
  name                = "hubfirewall"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name

  ip_configuration {
    name                 = "firewallconfiguration"
    subnet_id            = azurerm_subnet.vnet-hub-firewall-subnet.id
    public_ip_address_id = azurerm_public_ip.firewall-ip.id
  }
}