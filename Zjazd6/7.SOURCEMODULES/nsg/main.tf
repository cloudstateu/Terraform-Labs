data "azurerm_resource_group" "resource_group" {
    name                          = var.nsg_object.rg_name
}

resource "azurerm_network_security_group" "ab_network_security_group" {

    name                    = var.nsg_object.name
    
    resource_group_name     = data.azurerm_resource_group.resource_group.name
    location                = data.azurerm_resource_group.resource_group.location

    lifecycle {
      ignore_changes = [
          tags
      ]
    }
}