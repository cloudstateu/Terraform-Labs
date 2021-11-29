data "azurerm_resource_group" "ab_resource_group" {
    name     = var.rg_name
}

resource "azurerm_search_service" "ab_search_service" {

    name                            = var.name
    resource_group_name             = data.azurerm_resource_group.ab_resource_group.name
    location                        = data.azurerm_resource_group.ab_resource_group.location

    sku                             = var.sku 

    public_network_access_enabled   = false

    partition_count                 = var.partition_count
    replica_count                   = var.replica_count

    

    identity {
        type                        = "SystemAssigned"
    }

}

data "azurerm_log_analytics_workspace" "ab_log_analytics" {
    provider                      = azurerm.provider-log-analytics
    count                         = (var.log_analytics != null && var.log_analytics != "") ? 1 : 0

    name                          = var.log_analytics
    resource_group_name           = var.log_analytics_rg

}

resource "azurerm_monitor_diagnostic_setting" "ab_search_service_monitor" {
    provider                      = azurerm.provider-log-analytics
    count                         = (var.log_analytics != null && var.log_analytics != "") ? 1 : 0
    
    name                          = "diagnostics-${var.name}"
    target_resource_id            = azurerm_search_service.ab_search_service.id
    
    log_analytics_workspace_id    = data.azurerm_log_analytics_workspace.ab_log_analytics[0].id

    log {
        category = "OperationLogs"
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

resource "azurerm_private_endpoint" "ab_search_service_private_endpoint" {
    name                = "${var.name}-pe"
    location            = data.azurerm_resource_group.ab_resource_group.location
    resource_group_name = data.azurerm_resource_group.ab_resource_group.name
    subnet_id           = var.subnet_id

    private_service_connection {
        name                           = "${var.name}-private-connection"
        private_connection_resource_id = azurerm_search_service.ab_search_service.id
        is_manual_connection           = false
        subresource_names              = [ "searchService" ]
    }
}