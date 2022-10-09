resource "azurerm_storage_account" "storage" {
  name                     = local.storage_name
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = data.azurerm_resource_group.rg.location
  resource_group_name      = data.azurerm_resource_group.rg.name
}

resource "azurerm_storage_share" "appsvc_share_ghost_prod" {
  name                 = "${local.storage_name}-share"
  storage_account_name = azurerm_storage_account.storage.name
  quota                = 50
}
