resource "azurerm_storage_account" "storage" {
  account_tier             = "Standard"
  account_replication_type = "GRS"
  location                 = var.location
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
}

resource "azurerm_storage_container" "containers" {
  for_each = var.containers

  name                 = each.value.name
  storage_account_name = azurerm_storage_account.storage.name
}
