data "azurerm_resource_group" "ab_resource_group" {
    provider                        = azurerm.provider-diagnostic
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

resource "azurerm_log_analytics_linked_service" "ab_log_analytics_linked_service" {
    count               = (var.link_to_la_cluster == true) ? 1 : 0
    resource_group_name = data.azurerm_resource_group.ab_resource_group.name
    workspace_id        = azurerm_log_analytics_workspace.ab_log_analytics_workspace.id
    write_access_id     = var.la_cluster_id
}