resource "azurerm_resource_group" "dev-monitor-rg" {
  name     = "dev-monitor-rg"
  location = "westeurope"
}

resource "azurerm_log_analytics_workspace" "dev-monitor-loganal01" {
  name                = "dev-monitor-loganal01"
  location            = azurerm_resource_group.dev-monitor-rg.location
  resource_group_name = azurerm_resource_group.dev-monitor-rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb      = -1
}                   