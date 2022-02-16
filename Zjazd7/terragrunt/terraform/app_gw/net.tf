resource "azurerm_virtual_network" "vnet-hub" {
  provider            = azurerm.app_gw
  name                = "vnet-hub"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]

  tags = merge(var.resource_tags, { CreatedDate = timestamp() })

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

resource "azurerm_subnet" "sbn-app-gw" {
  provider             = azurerm.app_gw
  name                 = "sbn-app-gw"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["10.0.0.0/21"]
}
