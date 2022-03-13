data "azurerm_resource_group" "resource_group" {
    name                          = var.route_table_object.rg_name
}

resource "azurerm_route_table" "ab_route_table" {
    
    name                          = var.route_table_object.name

    resource_group_name           = data.azurerm_resource_group.resource_group.name
    location                      = data.azurerm_resource_group.resource_group.location
    
    disable_bgp_route_propagation = var.route_table_object.disable_bgp_route_propagation

    # NOTE: Tagi są ignorowane ze względu na dziedziczenie tagow z Resource Group
    lifecycle {
      ignore_changes = [
          tags
      ]
    }
}
