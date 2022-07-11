resource "azurerm_monitor_diagnostic_setting" "kv_to_log" {
  name                       = local.diagnostic_settings
  target_resource_id         = azurerm_key_vault.key-vault.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "app_to_log" {
  name                       = local.diagnostic_settings
  target_resource_id         = azurerm_linux_web_app.app.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }
}