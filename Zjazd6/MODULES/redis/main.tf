data "azurerm_resource_group" "resource_group" {
    provider            = azurerm.provider-redis
    name                = var.rg_name
}

resource "azurerm_redis_cache" "redis_cache" {
    provider                    = azurerm.provider-redis
    name                        = var.redis_name
    
    resource_group_name         = data.azurerm_resource_group.resource_group.name
    location                    = data.azurerm_resource_group.resource_group.location

    family                      = "P"       
    sku_name                    = "Premium" 

    capacity                    = 1         
 
    enable_non_ssl_port         = false
    
    minimum_tls_version         = "1.2"

    patch_schedule              {
        day_of_week             = var.patch_schedule.day_of_week
        start_hour_utc          = var.patch_schedule.start_hour_utc
    }

    private_static_ip_address   = var.private_static_ip_address

    redis_configuration {
        enable_authentication           = true

        maxmemory_reserved              = var.redis_configuration_maxmemory_reserved
        maxmemory_delta                 = var.redis_configuration_maxmemory_delta
        maxmemory_policy                = var.redis_configuration_maxmemory_policy
        maxfragmentationmemory_reserved = var.redis_configuration_maxfragmentationmemory_reserved

        rdb_backup_enabled              = var.redis_configuration_rdb_backup_enabled
        rdb_backup_frequency            = var.redis_configuration_rdb_backup_frequency
        rdb_backup_max_snapshot_count   = var.redis_configuration_rdb_backup_max_snapshot_count
        rdb_storage_connection_string   = var.redis_configuration_rdb_storage_connection_string
        notify_keyspace_events          = var.redis_configuration_notify_keyspace_events
    }

    subnet_id                           = var.subnet_id
     

    lifecycle {
        ignore_changes = [
            tags
        ]
    }
}

data "azurerm_log_analytics_workspace" "ab_log_analytics" {
    provider                      = azurerm.provider-log-analytics
    count                         = (var.redis_metrics_enabled != null && var.redis_metrics_enabled == true) ? 1 : 0

    name                          = var.redis_metrics_log_analytics_name
    resource_group_name           = var.redis_metrics_log_analytics_rg_name

}

resource "azurerm_monitor_diagnostic_setting" "ab_redis_monitor" {
    provider                      = azurerm.provider-log-analytics
    count                         = (var.redis_metrics_log_analytics_name != null && var.redis_metrics_log_analytics_name != "") ? 1 : 0
    
    name                          = "diagnostics-${var.redis_name}"
    target_resource_id            = azurerm_redis_cache.redis_cache.id
    
    log_analytics_workspace_id    = data.azurerm_log_analytics_workspace.ab_log_analytics[0].id

    metric {
        category = "AllMetrics"
        enabled  = true

        retention_policy {
            enabled = true
        }
    }
}