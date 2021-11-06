resource "azurerm_private_dns_zone" "akszone" {
  name                = "akszone.privatelink.westeurope.azmk8s.io"
  resource_group_name = azurerm_resource_group.dev-dns-rg.name

}

resource "azurerm_private_dns_zone_virtual_network_link" "akszone" {
  name                  = "akszone"
  resource_group_name   = azurerm_resource_group.dev-dns-rg.name
  private_dns_zone_name = azurerm_private_dns_zone.akszone.name
  virtual_network_id    = azurerm_virtual_network.vnet-dev-10-100-0-0--16.id
}