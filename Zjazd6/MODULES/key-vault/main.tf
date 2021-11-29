data "azurerm_resource_group" "ab_resource_group" {
    name                            = var.rg_name
}

resource "azurerm_key_vault" "ab_key_vault" {

    name                            = var.name

    resource_group_name             = data.azurerm_resource_group.ab_resource_group.name
    location                        = data.azurerm_resource_group.ab_resource_group.location

    sku_name                        = var.sku
    tenant_id                       = var.tenant_id

    enabled_for_deployment          = var.enabled_for_deployment
    enabled_for_disk_encryption     = var.enabled_for_disk_encryption
    enabled_for_template_deployment = var.enabled_for_template_deployment

    enable_rbac_authorization       = var.enable_rbac_authorization

    purge_protection_enabled        = var.purge_protection_enabled
    soft_delete_retention_days      = var.soft_delete_retention_days

    network_acls {
        bypass                     = var.network_acls_bypass
        default_action             = "Deny"
        ip_rules                   = var.network_acls_ip_list
        virtual_network_subnet_ids = var.network_acls_subnet_ids
    }

    lifecycle {
        ignore_changes = [
            tags
        ]
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
    target_resource_id            = azurerm_key_vault.ab_key_vault.id
    
    log_analytics_workspace_id    = data.azurerm_log_analytics_workspace.ab_log_analytics[0].id

    log {
        category = "AuditEvent"
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