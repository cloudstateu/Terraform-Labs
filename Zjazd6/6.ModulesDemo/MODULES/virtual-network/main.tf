data "azurerm_resource_group" "resource_group" {
    name = var.vnet_object.rg_name
}

resource "azurerm_virtual_network" "ab_virtual_network" {
    
    name                = var.vnet_object.name
    location            = data.azurerm_resource_group.resource_group.location
    resource_group_name = data.azurerm_resource_group.resource_group.name
    address_space       = var.vnet_object.address_space
    dns_servers         = var.vnet_object.dns_servers
    
    
    lifecycle {
      ignore_changes = [
          tags
      ]
    }
}
