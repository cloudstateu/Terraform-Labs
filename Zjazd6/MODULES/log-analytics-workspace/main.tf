data "azurerm_resource_group" "ab_resource_group" {
    name                            = var.rg_name
}

resource "azurerm_log_analytics_workspace" "ab_log_analytics_workspace" {
    name                                = var.name
    location                            = data.azurerm_resource_group.ab_resource_group.location
    resource_group_name                 = data.azurerm_resource_group.ab_resource_group.name
    sku                                 = "PerGB2018"
    retention_in_days                   = var.retention_in_days
    internet_ingestion_enabled          = var.internet_ingestion_enabled
    internet_query_enabled              = var.internet_query_enabled
    
    lifecycle {
        ignore_changes = [
            tags
        ]
    }
}

data "azurerm_log_analytics_workspace" "ab_log_analytics" {
    provider                      = azurerm.provider-diagnostic
    count                         = (var.log_analytics != null && var.log_analytics != "") ? 1 : 0

    name                          = var.log_analytics
    resource_group_name           = var.log_analytics_rg

}

resource "azurerm_monitor_diagnostic_setting" "ab_log_analytics_monitor" {
    provider                      = azurerm.provider-diagnostic
    count                         = (var.log_analytics != null && var.log_analytics != "") ? 1 : 0
    
    name                          = "diagnostics-${var.name}"
    target_resource_id            = azurerm_log_analytics_workspace.ab_log_analytics_workspace.id
    
    log_analytics_workspace_id    = data.azurerm_log_analytics_workspace.ab_log_analytics[0].id

    log {
        category = "Audit"
        enabled  = true

        retention_policy {
            enabled = true
        }
    }

    metric {
        category = "AllMetrics"
        enabled  = true

        retention_policy {
            enabled = true
        }
    }
}

resource "azurerm_log_analytics_linked_service" "ab_log_analytics_linked_service" {
    count               = (var.link_to_la_cluster == true) ? 1 : 0
    resource_group_name = data.azurerm_resource_group.ab_resource_group.name
    workspace_id        = azurerm_log_analytics_workspace.ab_log_analytics_workspace.id
    write_access_id     = var.la_cluster_id
}