data "azurerm_virtual_network" "vnet-1" {

    provider            = azurerm.vnet1
    
    name                = var.peering_object.vnet1_name
    resource_group_name = var.peering_object.vnet1_rg_name

}

data "azurerm_virtual_network" "vnet-2" {
    
    provider            = azurerm.vnet2

    name                = var.peering_object.vnet2_name
    resource_group_name = var.peering_object.vnet2_rg_name
}


resource "azurerm_virtual_network_peering" "vnet-1-to-vnet-2" {
   
   provider                  = azurerm.vnet1

   name                      = "${data.azurerm_virtual_network.vnet-1.name}-to-${data.azurerm_virtual_network.vnet-2.name}"
   resource_group_name       = var.peering_object.vnet1_rg_name
   virtual_network_name      = data.azurerm_virtual_network.vnet-1.name
   remote_virtual_network_id = data.azurerm_virtual_network.vnet-2.id
   allow_forwarded_traffic   = var.peering_object.vnet_1_allow_forwarded_traffic
   use_remote_gateways       = var.peering_object.vnet_1_use_remote_gateways
   allow_gateway_transit     = var.peering_object.vnet_1_allow_gateway_transit
}

resource "azurerm_virtual_network_peering" "vnet-2-to-vnet-1" {

    provider                 = azurerm.vnet2

   name                      = "${data.azurerm_virtual_network.vnet-2.name}-to-${data.azurerm_virtual_network.vnet-1.name}"
   resource_group_name       = var.peering_object.vnet2_rg_name
   virtual_network_name      = data.azurerm_virtual_network.vnet-2.name
   remote_virtual_network_id = data.azurerm_virtual_network.vnet-1.id
   allow_forwarded_traffic   = var.peering_object.vnet_2_allow_forwarded_traffic
   use_remote_gateways       = var.peering_object.vnet_2_use_remote_gateways
   allow_gateway_transit     = var.peering_object.vnet_2_allow_gateway_transit
}