resource "azurerm_network_watcher_flow_log" "test" {
  network_watcher_name = "NetworkWatcher_westeurope"
  resource_group_name  = "NetworkWatcherRG"

  network_security_group_id = azurerm_network_security_group.NSG-FRONTEND[0].id
  storage_account_id        = azurerm_storage_account.aksflowlogmf01.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 7
  }

}

resource "azurerm_storage_account" "aksflowlogmf01" {
  name                     = "aksflowlogmf01"
  location                 = azurerm_resource_group.dev-net-rg.location
  resource_group_name      = azurerm_resource_group.dev-net-rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}