
resource "azurerm_app_service_plan" "aps-mf-dev-01" {
  name                = "aps-mf-dev-01"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  sku {
    tier = "Standard"
    size = "S1"
    capacity = 1
  }
}

resource "azurerm_app_service" "app-mf-appdev01" {
  name                = var.app-serv-name
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  app_service_plan_id = azurerm_app_service_plan.aps-mf-dev-01.id

  app_settings = {
    "WEBSITE_DNS_SERVER" : "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL" : "1"
    "ENVNAME" : "app-mf-appdev01"
  }
}

resource "azurerm_app_service" "app-mf-appdev02" {
  name                = "${var.app-serv-name}-${local.studentPrefix}"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  app_service_plan_id = azurerm_app_service_plan.aps-mf-dev-01.id

  app_settings = {
    "WEBSITE_DNS_SERVER" : "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL" : "1"
    "ENVNAME" : "app-mf-appdev01"
  }
}
resource "azurerm_private_dns_zone" "privatelink-azurewebsites-net" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.main_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet-hub-privatelink-azurewebsites-net-dnszone-virtuallink" {
  name                  = "vnet-hub-privatelink-azurewebsites-net-dnszone-virtuallink"
  resource_group_name   = azurerm_resource_group.main_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-azurewebsites-net.name
  virtual_network_id    = azurerm_virtual_network.vnet-hub.id
}

/*
resource "azurerm_private_endpoint" "aps-mf-dev-01-pe" {
  name                = "aps-mf-dev-01-pe"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  subnet_id           = azurerm_subnet.vnet-hub-private-app-service-subnet.id

  private_service_connection {
    name                           = "aps-mf-dev-01-pe-connection"
    private_connection_resource_id = azurerm_app_service.app-mf-appdev01.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}*


/*resource "azurerm_private_dns_a_record" "app-fqdn1" {
  name                = substr(azurerm_private_endpoint.privateappendpoint.custom_dns_configs[0].fqdn, 0, 23)
  zone_name           = azurerm_private_dns_zone.appprivzone.name
  resource_group_name = azurerm_resource_group.main_rg.name
  ttl                 = 300
  records             = azurerm_private_endpoint.privateappendpoint.custom_dns_configs[0].ip_addresses
}
*/