data "azurerm_resource_group" "resource_group" {
    name                                        = var.nsg_rule_object.rg_name
}
resource "azurerm_network_security_rule" "ab_network_security_rule" {

    resource_group_name                         = data.azurerm_resource_group.resource_group.name
    network_security_group_name                 = var.nsg_rule_object.nsg_name

    name                                        = var.nsg_rule_object.name
    description                                 = var.nsg_rule_object.description

    direction                                   = var.nsg_rule_object.direction
    priority                                    = var.nsg_rule_object.priority
    access                                      = var.nsg_rule_object.access
    protocol                                    = var.nsg_rule_object.protocol

    source_address_prefix                       = var.nsg_rule_object.source_address_prefix
    source_port_range                           = var.nsg_rule_object.source_port_range

    destination_address_prefix                  = var.nsg_rule_object.destination_address_prefix
    destination_port_range                      = var.nsg_rule_object.destination_port_range 

    source_application_security_group_ids       = (var.nsg_rule_object.source_application_security_group_ids == null) ? null : var.nsg_rule_object.source_application_security_group_ids
    destination_application_security_group_ids  = (var.nsg_rule_object.destination_application_security_group_ids == null) ? null : var.nsg_rule_object.destination_application_security_group_ids
    
}