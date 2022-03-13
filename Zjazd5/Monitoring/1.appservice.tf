resource "azurerm_resource_group" "main_rg" {
  name = "main_rg"
  location = "westeurope"
}


resource "azurerm_app_service_plan" "aps-mf-dev-01" {
  name                = "aps-mf-dev-01"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  sku {
    tier = "Standard"
    size = "S1"
    capacity = 1
  }
}

resource "azurerm_app_service" "app-mf-appdev01" {
  name                = "app-mf-appdev01"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  app_service_plan_id = azurerm_app_service_plan.aps-mf-dev-01.id

  app_settings = {
    "WEBSITE_DNS_SERVER" : "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL" : "1"
    "ENVNAME" : "app-mf-appdev01"
  }
}

resource "azurerm_storage_account" "stlogs" {
  name                     = "stlogs12mf"
  location                = azurerm_resource_group.main_rg.location
  resource_group_name     = azurerm_resource_group.main_rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_monitor_diagnostic_setting" "app-mf-appdev01-monitoring" {
    #provider                      = azurerm.provider-log-analytics
    #count                         = (var.app_service_object.log_analytics != null && var.app_service_object.log_analytics != "") ? 1 : 0
    
    name                          = "diagnostics-${azurerm_app_service.app-mf-appdev01.name}"
    
    #id App Service, ktory ma zrzucac Log
    target_resource_id            = azurerm_app_service.app-mf-appdev01.id
    
    #id Log Analytics, do którego log ma trafić
    log_analytics_workspace_id    = azurerm_log_analytics_workspace.loganal01.id

    storage_account_id = azurerm_storage_account.stlogs.id

    #metryki i logi z App Service, ktore maja trafic do Log Analytics
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

data "azurerm_monitor_diagnostic_categories" "azurerm_monitor_diagnostic_setting_azureappservice" {
  #ID Serwisu dla którego chcemy sprawdzić metryki i logi, które możemy logować
  resource_id = azurerm_app_service.app-mf-appdev01.id
}

output "azurerm_monitor_diagnostic_setting_azureappservice_logs" {
  #Wypisanie listy tzw. Logs, które można logować
   value = data.azurerm_monitor_diagnostic_categories.azurerm_monitor_diagnostic_setting_azureappservice.logs
}

output "azurerm_monitor_diagnostic_setting_azureappservice_metrics" {
   #Wypisanie listy Metrics, które można logować
   value = data.azurerm_monitor_diagnostic_categories.azurerm_monitor_diagnostic_setting_azureappservice.metrics
}