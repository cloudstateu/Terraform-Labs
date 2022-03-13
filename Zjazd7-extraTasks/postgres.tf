#
locals {
  random_suffix_pg = substr(sha1(format("%s/%s",var.subscription_id,azurerm_resource_group.pg_rg.name)),0,5)
}

resource "azurerm_postgresql_server" "pdw-postgres1" {
  name                = format("%s%s","pdw-postgres1",local.random_suffix_pg)
  location            = azurerm_resource_group.pg_rg.location
  resource_group_name = azurerm_resource_group.pg_rg.name

  administrator_login          = "psqladmin"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "GP_Gen5_4"
  version    = "9.6"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = false
#  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_virtual_network_rule" "pg_vnrule" {
  name                                 = "pg-vnet-rule"
  resource_group_name                  = azurerm_resource_group.pg_rg.name
  server_name                          = azurerm_postgresql_server.pdw-postgres1.name
  subnet_id                            = azurerm_subnet.pg-sub.id
  ignore_missing_vnet_service_endpoint = true
}