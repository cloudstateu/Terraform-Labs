resource "azurerm_key_vault" "key-vault" {
  name                = local.kv_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id

  purge_protection_enabled = false

  access_policy {
    object_id = data.azurerm_client_config.current.object_id
    tenant_id = data.azurerm_client_config.current.tenant_id

    key_permissions = [
      "Create",
      "Get",
      "List",
      "Purge"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]
  }
}

resource "random_password" "mysql-server-password" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "mysql-password" {
  name         = "mysql-password"
  value        = random_password.mysql-server-password.result
  key_vault_id = azurerm_key_vault.key-vault.id
}

