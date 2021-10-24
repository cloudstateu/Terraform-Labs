
resource "azurerm_app_service_plan" "aps-mf-dev-01" {
  name                = "aps-mf-dev-01"
  location            = azurerm_resource_group.appservice-dev.location
  resource_group_name = azurerm_resource_group.appservice-dev.name

  sku {
    #TODO: mifurm, Private Endpoint dla AppService są tylko w planie Premium, wybieram więc najmniejszą wersję P1v2
    tier     = "PremiumV2"
    size     = "P1v2"
    capacity = 1
  }
}

resource "azurerm_app_service" "app-mf-appdev01" {
  name                = "${random_string.mifurm-rand-prefix.result}-appdev01-${local.studentPrefix}"
  location            = azurerm_resource_group.appservice-dev.location
  resource_group_name = azurerm_resource_group.appservice-dev.name
  app_service_plan_id = azurerm_app_service_plan.aps-mf-dev-01.id

  app_settings = {
    "WEBSITE_DNS_SERVER" : "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL" : "1"
    "ENVNAME" : "app-mf-appdev01"
  }
}

resource "azurerm_app_service" "app-mf-appdev02" {
  name                = "${random_string.mifurm-rand-prefix.result}-appdev02-${local.studentPrefix}"
  location            = azurerm_resource_group.appservice-dev.location
  resource_group_name = azurerm_resource_group.appservice-dev.name
  app_service_plan_id = azurerm_app_service_plan.aps-mf-dev-01.id

  app_settings = {
    "WEBSITE_DNS_SERVER" : "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL" : "2"
    "ENVNAME" : "app-mf-appdev02"
  }
}

resource "azurerm_private_endpoint" "aps-mf-dev-01-pe" {
  name                = "aps-mf-dev-01-pe"
  location            = azurerm_resource_group.netops-prd-spoke.location
  resource_group_name = azurerm_resource_group.netops-prd-spoke.name
  subnet_id           = azurerm_subnet.vnet-spoke-prd-private-app-service-subnet.id

  private_service_connection {
    name                           = "aps-mf-dev-01-pe-connection"
    private_connection_resource_id = azurerm_app_service.app-mf-appdev01.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}

#TODO: mifurm, dodaję wpis DNS dla pierwszego AppService
resource "azurerm_private_dns_a_record" "aps-mf-dev-01-pe-dns-a-record" {
  name = azurerm_app_service.app-mf-appdev01.name
  #substr(azurerm_private_endpoint.aps-mf-dev-01-pe.custom_dns_configs[0].fqdn, 0, 23)
  zone_name           = azurerm_private_dns_zone.privatelink-azurewebsites-net.name
  resource_group_name = azurerm_resource_group.netops-prd-dns.name
  ttl                 = 300
  records             = azurerm_private_endpoint.aps-mf-dev-01-pe.custom_dns_configs[0].ip_addresses
}

#TODO: mifurm, dodaję drugi PE
resource "azurerm_private_endpoint" "aps-mf-dev-02-pe" {
  name                = "aps-mf-dev-02-pe"
  location            = azurerm_resource_group.netops-prd-spoke.location
  resource_group_name = azurerm_resource_group.netops-prd-spoke.name
  subnet_id           = azurerm_subnet.vnet-spoke-prd-private-app-service-subnet.id

  private_service_connection {
    name                           = "aps-mf-dev-02-pe-connection"
    private_connection_resource_id = azurerm_app_service.app-mf-appdev02.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}

#TODO: mifurm, dodaję wpis DNS dla drugiego AppService
resource "azurerm_private_dns_a_record" "aps-mf-dev-02-pe-dns-a-record" {
  name = azurerm_app_service.app-mf-appdev02.name
  #substr(azurerm_private_endpoint.aps-mf-dev-01-pe.custom_dns_configs[0].fqdn, 0, 23)
  zone_name           = azurerm_private_dns_zone.privatelink-azurewebsites-net.name
  resource_group_name = azurerm_resource_group.netops-prd-dns.name
  ttl                 = 300
  records             = azurerm_private_endpoint.aps-mf-dev-02-pe.custom_dns_configs[0].ip_addresses
}