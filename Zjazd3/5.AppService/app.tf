resource "azurerm_service_plan" "plan" {
  name                = local.service_plan_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "P2v3"
}

resource "azurerm_linux_web_app" "app" {
  name                      = local.app_name
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = azurerm_service_plan.plan.location
  service_plan_id           = azurerm_service_plan.plan.id
  virtual_network_subnet_id = azurerm_subnet.app.id

  app_settings = {
    "database__client" : "mysql",
    "database__connection__database" : azurerm_mysql_database.ghost.name,
    "database__connection__host" : "${azurerm_mysql_server.mysql.name}.${azurerm_private_dns_zone.mysql.name}",
    "database__connection__password" : "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.key-vault.name};SecretName=${azurerm_key_vault_secret.mysql-password.name})",
    "database__connection__ssl" : "true",
    "database__connection__user" : "${azurerm_mysql_server.mysql.administrator_login}@${lower(azurerm_mysql_server.mysql.name)}",
    "paths_contentPath" : "/var/lib/storage",
    #"url": "",
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" : "true",
  }

  site_config {
    always_on     = true
    http2_enabled = true

    application_stack {
      docker_image     = "ghost"
      docker_image_tag = "3.42.8"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  storage_account {
    name         = "appservice-ghost-primary-prod-pathMapping"
    type         = "AzureFiles"
    account_name = azurerm_storage_account.storage.name
    share_name   = azurerm_storage_share.appsvc-share-ghost-prod.name
    access_key   = azurerm_storage_account.storage.primary_access_key
    mount_path   = "/var/lib/storage"
  }
}

resource "azurerm_key_vault_access_policy" "appservice-ghost-primary-prod" {
  key_vault_id       = azurerm_key_vault.key-vault.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azurerm_linux_web_app.app.identity[0].principal_id
  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set"
  ]
}
