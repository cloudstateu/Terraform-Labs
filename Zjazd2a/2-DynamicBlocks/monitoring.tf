resource "azurerm_log_analytics_workspace" "law" {
  name                = "bankstudent0law"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
}

resource "azurerm_monitor_diagnostic_setting" "sa" {
  name                       = "sa-logs-ds"
  target_resource_id         = azurerm_storage_account.sa.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.categories.metrics
    content {
      enabled  = true
      category = metric.value
    }
  }

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.categories.logs
    content {
      enabled  = true
      category = log.value
    }
  }
}
