resource "azurerm_subnet" "ab_subnet" {
    name                                           = var.subnet_object.name
    
    resource_group_name                            = var.subnet_object.rg_name
    virtual_network_name                           = var.subnet_object.vnet_name

    address_prefixes                               = var.subnet_object.address_space
    enforce_private_link_endpoint_network_policies = var.subnet_object.private_link_endpoint_network_policies
    enforce_private_link_service_network_policies  = var.subnet_object.private_link_service_network_policies

    service_endpoints                              = var.subnet_object.service_endpoints
    service_endpoint_policy_ids                    = length(var.subnet_object.service_endpoint_policy_ids) > 0 ? var.subnet_object.service_endpoint_policy_ids : null

    dynamic "delegation" {
        for_each                                   = var.subnet_delegation
        content {
            name                                   = delegation.key
            
            dynamic "service_delegation" {
                for_each                           = toset(delegation.value)
                content {
                    name                           = service_delegation.value.name
                    actions                        = service_delegation.value.actions
                }
            }        
        }
    }
}

resource "azurerm_subnet_route_table_association" "ab_subnet_route_table_association" {
    count                                           = var.subnet_object.route_table_id != null && var.subnet_object.route_table_id != "" ? 1 : 0

    subnet_id                                       = azurerm_subnet.ab_subnet.id
    route_table_id                                  = var.subnet_object.route_table_id
}

resource "azurerm_subnet_network_security_group_association" "ab_subnet_network_security_group_association" {
    count                                           = var.subnet_object.nsg_id != null && var.subnet_object.nsg_id != "" ? 1 : 0

    subnet_id                                       = azurerm_subnet.ab_subnet.id
    network_security_group_id                       = var.subnet_object.nsg_id
}
