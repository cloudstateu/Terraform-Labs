resource "azurerm_key_vault" "kv-mf-dev-01" {
  name                = "mf-${var.key-vault-name}"
  location            = azurerm_resource_group.kv-dev.location
  resource_group_name = azurerm_resource_group.kv-dev.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create", "Delete", "List"
    ]

    secret_permissions = [
      "Get", "Set", "Delete", "List"
    ]

    storage_permissions = [
      "Get", "Set", "Delete", "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "keyvault-secret-01" {
  name         = "keyvault-secret-01"
  value        = "terraform-is-cool"
  key_vault_id = azurerm_key_vault.kv-mf-dev-01.id
}

#TODO: dodaje PE dla KeyVault
#Wazny link:https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview
resource "azurerm_private_endpoint" "kv-mf-dev-01-pe" {
  name                = "kv-mf-dev-01-pe"
  location            = azurerm_resource_group.netops-prd-spoke.location
  resource_group_name = azurerm_resource_group.netops-prd-spoke.name
  subnet_id           = azurerm_subnet.vnet-spoke-prd-private-app-service-subnet.id

  private_service_connection {
    name                           = "kv-mf-dev-01-pe-connection"
    private_connection_resource_id = azurerm_key_vault.kv-mf-dev-01.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

#TODO: mifurm, dodaje wpis w DNS
resource "azurerm_private_dns_a_record" "app-fqdn1" {
  name                = azurerm_key_vault.kv-mf-dev-01.name
  zone_name           = azurerm_private_dns_zone.privatelink-keyvault-net.name
  resource_group_name = azurerm_resource_group.netops-prd-dns.name
  ttl                 = 300
  records             = azurerm_private_endpoint.kv-mf-dev-01-pe.custom_dns_configs[0].ip_addresses
}
