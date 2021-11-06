

# provider "azurerm" {
#   features {
#     key_vault {
#       purge_soft_delete_on_destroy = true
#     }
#   }
# }

# resource "azurerm_key_vault" "example" {
#   name                        = "des-mifurm-keyvault-2"
#   location                    = azurerm_resource_group.dev-prolab-rg[0].location
#   resource_group_name         = azurerm_resource_group.dev-prolab-rg[0].name
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   sku_name                    = "premium"
#   enabled_for_disk_encryption = true
#   soft_delete_enabled         = true
#   purge_protection_enabled    = true

#    access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     key_permissions = [
#       "Get", "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey" 
#     ]

#     secret_permissions = [
#       "Get",
#     ]

#     storage_permissions = [
#       "Get",
#     ]
#   }

# }

# resource "azurerm_key_vault_key" "example" {
#   name         = "des-example-key"
#   key_vault_id = azurerm_key_vault.example.id
#   key_type     = "RSA"
#   key_size     = 2048

#   depends_on = [
#     azurerm_key_vault_access_policy.example-user
#   ]

#   key_opts = [
#     "decrypt",
#     "encrypt",
#     "sign",
#     "unwrapKey",
#     "verify",
#     "wrapKey",
#   ]
# }

# resource "azurerm_disk_encryption_set" "example" {
#   name                = "des"
#   location                    = azurerm_resource_group.dev-prolab-rg[0].location
#   resource_group_name         = azurerm_resource_group.dev-prolab-rg[0].name
#   key_vault_key_id    = azurerm_key_vault_key.example.id

#   identity {
#     type = "SystemAssigned"
#   }
# }

# resource "azurerm_key_vault_access_policy" "example-disk" {
#   key_vault_id = azurerm_key_vault.example.id

#   tenant_id = azurerm_disk_encryption_set.example.identity.0.tenant_id
#   object_id = azurerm_disk_encryption_set.example.identity.0.principal_id

#   key_permissions = [
#     "Get",
#     "WrapKey",
#     "UnwrapKey"
#   ]
# }

# resource "azurerm_key_vault_access_policy" "example-user" {
#   key_vault_id = azurerm_key_vault.example.id

#   tenant_id = data.azurerm_client_config.current.tenant_id
#   object_id = data.azurerm_client_config.current.object_id

#   key_permissions = [
#     "get",
#     "create",
#     "delete"
#   ]
# }