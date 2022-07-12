#resource "azurerm_key_vault" "key-vault" {
#  name                = local.kv_name
#  location            = "eastus"
#  resource_group_name = data.azurerm_resource_group.rg.name
#  sku_name            = "standard"
#  tenant_id           = data.azurerm_client_config.current.tenant_id
#
#  purge_protection_enabled = false
#}
