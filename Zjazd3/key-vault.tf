resource "azurerm_key_vault" "kv-mf-dev-01" {
  name                        = var.key-vault-name
  location                    = azurerm_resource_group.main_rg.location
  resource_group_name         = azurerm_resource_group.main_rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id

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