resource "azurerm_private_dns_zone" "key_vault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone" "file" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone" "mysql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "key_vault" {
  name                  = "key_vault"
  private_dns_zone_name = azurerm_private_dns_zone.key_vault.name
  resource_group_name   = data.azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "file" {
  name                  = "file"
  private_dns_zone_name = azurerm_private_dns_zone.file.name
  resource_group_name   = data.azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql" {
  name                  = "mysql"
  private_dns_zone_name = azurerm_private_dns_zone.mysql.name
  resource_group_name   = data.azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_endpoint" "key-vault" {
  name                = "pe-app-${var.resources_suffix}-kv"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.endpoints.id

  private_service_connection {
    is_manual_connection           = false
    name                           = "pe-app-${var.resources_suffix}-kv"
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name = "pe-app-${var.resources_suffix}-kv"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.key_vault.id
    ]
  }
}

resource "azurerm_private_endpoint" "file" {
  name                = "pe-app-${var.resources_suffix}-file"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.endpoints.id

  private_service_connection {
    name                           = "pe-app-${var.resources_suffix}-file"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = ["file"]
  }

  private_dns_zone_group {
    name                 = "pe-app-${var.resources_suffix}-file"
    private_dns_zone_ids = [azurerm_private_dns_zone.file.id]
  }
}

resource "azurerm_private_endpoint" "pe_mysqlmaster_primary_region" {
  name                = "pe-app-${var.resources_suffix}-mysql"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.endpoints.id

  private_service_connection {
    name                           = "pe-app-${var.resources_suffix}-mysql"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mysql_server.mysql.id
    subresource_names              = ["mysqlServer"]
  }

  private_dns_zone_group {
    name                 = "pe-app-${var.resources_suffix}-mysql"
    private_dns_zone_ids = [azurerm_private_dns_zone.mysql.id]
  }
}
