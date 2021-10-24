#TODO: mifurm, dodaje nowy plik z potrzebnymi strefami prywatnymi
# plik zawiera dwie strefy prywatne i dowiązania
resource "azurerm_private_dns_zone" "privatelink-azurewebsites-net" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.netops-prd-dns.name
}

resource "azurerm_private_dns_zone" "privatelink-keyvault-net" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.netops-prd-dns.name
}

#TODO: mifurm, dodaje dowiazanie - VNET-HUB
resource "azurerm_private_dns_zone_virtual_network_link" "vnet-hub-privatelink-azurewebsites-net-dnszone-virtuallink" {
  name                  = "vnet-hub-privatelink-azurewebsites-net-dnszone-virtuallink"
  resource_group_name   = azurerm_resource_group.netops-prd-dns.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-azurewebsites-net.name
  virtual_network_id    = azurerm_virtual_network.vnet-hub.id
}

#TODO: mifurm, dodaje dowiazanie - VNET-HUB
resource "azurerm_private_dns_zone_virtual_network_link" "vnet-hub-privatelink-keyvault-net-dnszone-virtuallink" {
  name                  = "vnet-hub-privatelink-keyvault-net-dnszone-virtuallink"
  resource_group_name   = azurerm_resource_group.netops-prd-dns.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-keyvault-net.name
  virtual_network_id    = azurerm_virtual_network.vnet-hub.id
}

#TODO: mifurm, dodaje dowiazanie - VNET-SPOKE-PRD
resource "azurerm_private_dns_zone_virtual_network_link" "vnet-spoke-prd-privatelink-azurewebsites-net-dnszone-virtuallink" {
  name                  = "vnet-spoke-prd-privatelink-azurewebsites-net-dnszone-virtuallink"
  resource_group_name   = azurerm_resource_group.netops-prd-dns.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-azurewebsites-net.name
  virtual_network_id    = azurerm_virtual_network.vnet-spoke-prd.id
}

#TODO: mifurm, dodaje dowiazanie - VNET-SPOKE-PRD
resource "azurerm_private_dns_zone_virtual_network_link" "vnet-spoke-prd-privatelink-keyvault-net-dnszone-virtuallink" {
  name                  = "vnet-spoke-prd-privatelink-keyvault-net-dnszone-virtuallink"
  resource_group_name   = azurerm_resource_group.netops-prd-dns.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-keyvault-net.name
  virtual_network_id    = azurerm_virtual_network.vnet-spoke-prd.id
}

#TODO: mifurm, dodaje dowiazanie - VNET-SPOKE-DEV
resource "azurerm_private_dns_zone_virtual_network_link" "vnet-spoke-dev-privatelink-azurewebsites-net-dnszone-virtuallink" {
  name                  = "vnet-spoke-dev-privatelink-azurewebsites-net-dnszone-virtuallink"
  resource_group_name   = azurerm_resource_group.netops-prd-dns.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-azurewebsites-net.name
  virtual_network_id    = azurerm_virtual_network.vnet-spoke-dev.id
}

#TODO: mifurm, dodaje dowiazanie - VNET-SPOKE-DEV
resource "azurerm_private_dns_zone_virtual_network_link" "vnet-spoke-dev-privatelink-keyvault-net-dnszone-virtuallink" {
  name                  = "vnet-spoke-dev-privatelink-keyvault-net-dnszone-virtuallink"
  resource_group_name   = azurerm_resource_group.netops-prd-dns.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-keyvault-net.name
  virtual_network_id    = azurerm_virtual_network.vnet-spoke-dev.id
}

#terraform import azurerm_private_dns_zone_virtual_network_link.vnet-spoke-prd-privatelink-azurewebsites-net-dnszone-virtuallink "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8/resourceGroups/rg-tf-st60-netops-prd-dns/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net/virtualNetworkLinks/vnet-spoke-prd-privatelink-azurewebsites-net-dnszone-virtuallink"