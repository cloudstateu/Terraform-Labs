data "azurerm_resource_group" "module01-rg" {
  name = "module01-rg"
}

data "azurerm_resource_group" "monitoring-dev-rg" {
  provider = azurerm.provider-devenv-sub
  name     = "monitoring-dev-rg"
}

data "azurerm_virtual_network" "vnet-dev-01" {
    resource_group_name = data.azurerm_resource_group.module01-rg.name
    name = "vnet-dev-01"
}

data "azurerm_subnet" "subnet-01" {
    virtual_network_name = data.azurerm_virtual_network.vnet-dev-01.name
    resource_group_name = data.azurerm_resource_group.module01-rg.name
    name = "subnet-01"
}