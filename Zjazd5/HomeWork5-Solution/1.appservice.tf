resource "azurerm_resource_group" "homework-rg" {
  name     = "homework-rg"
  location = "westeurope"
}

resource "azurerm_app_service_plan" "apsmfhw-dev-01" {
  name                = "apsmfhw-dev-01"
  location            = azurerm_resource_group.homework-rg.location
  resource_group_name = azurerm_resource_group.homework-rg.name

  sku {
    tier     = "Standard"
    size     = "S1"
    capacity = 1
  }
}

resource "azurerm_app_service" "app-mfhw-appdev01" {
  name                = "app-mfhw-appdev01"
  location            = azurerm_resource_group.homework-rg.location
  resource_group_name = azurerm_resource_group.homework-rg.name
  app_service_plan_id = azurerm_app_service_plan.apsmfhw-dev-01.id
}

resource "azurerm_monitor_diagnostic_setting" "app-mf-appdev01-monitoring" {

  name               = "diagnostics-${azurerm_app_service.app-mfhw-appdev01.name}"
  target_resource_id = azurerm_app_service.app-mfhw-appdev01.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.dev-monitor-loganal01.id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }

  log {
    category = "AppServicePlatformLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  log {
    category = "AppServiceAppLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  log {
    category = "AppServiceAuditLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  log {
    category = "AppServiceConsoleLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  log {
    category = "AppServiceHTTPLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  log {
    category = "AppServiceIPSecAuditLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  log {
    category = "AppServicePlatformLogs"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }


}