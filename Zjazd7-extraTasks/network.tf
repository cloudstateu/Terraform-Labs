resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = azurerm_resource_group.networking_rg.location
  resource_group_name = azurerm_resource_group.networking_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "pg-sub" {
    name                 = "pg-sub"
    virtual_network_name = azurerm_virtual_network.vnet1.name
    resource_group_name  = azurerm_resource_group.networking_rg.name
    address_prefixes     = ["10.0.0.0/28"]
}

resource "azurerm_subnet" "redis-sub" {
    name                 = "redis-sub"
    virtual_network_name = azurerm_virtual_network.vnet1.name
    resource_group_name  = azurerm_resource_group.networking_rg.name
    address_prefixes     = ["10.0.1.0/28"]
}

resource "azurerm_subnet" "legacy-sub" {
    name                 = "legacy-sub"
    virtual_network_name = azurerm_virtual_network.vnet1.name
    resource_group_name  = azurerm_resource_group.networking_rg.name
    address_prefixes     = ["10.0.2.0/28"]
}

resource "azurerm_subnet" "ase-sub" {
    name                 = "ase-sub"
    virtual_network_name = azurerm_virtual_network.vnet1.name
    resource_group_name  = azurerm_resource_group.networking_rg.name
    address_prefixes     = ["10.0.3.0/24"] # /24 is required for ASE
 }

resource "azurerm_subnet" "cdn-sub" {
    name                 = "cdn-sub"
    virtual_network_name = azurerm_virtual_network.vnet1.name
    resource_group_name  = azurerm_resource_group.networking_rg.name
    address_prefixes     = ["10.0.4.0/28"]
}
