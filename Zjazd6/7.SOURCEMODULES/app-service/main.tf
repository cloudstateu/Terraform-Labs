data "azurerm_subnet" "ab_ase_subnet" {
    name                 = var.app_service_object.subnet_name
    virtual_network_name = var.app_service_object.vnet_name
    resource_group_name  = var.app_service_object.vnet_rg_name
}

resource "azurerm_app_service_environment" "app_service_environment" {
    name                         = var.app_service_object.ase_name
    resource_group_name          = var.app_service_object.ase_rg_name

    subnet_id                    = data.azurerm_subnet.ab_ase_subnet.id
    pricing_tier                 = var.app_service_object.ase_tier

    front_end_scale_factor       = var.app_service_object.ase_front_scale_factor
    
    internal_load_balancing_mode = var.app_service_object.ase_vnet_endpoints
    allowed_user_ip_cidrs        = var.app_service_object.ase_egress_ips
        
    cluster_setting {
        name  = "DisableTls1.0"
        value = "1"
    }

    cluster_setting {
        name  = "InternalEncryption"
        value = "true"
    }

    cluster_setting {
        name  = "FrontEndSSLCipherSuiteOrder"
        value = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
    }

    lifecycle {
      ignore_changes = [
          tags
      ]
    }
        
}

data "azurerm_log_analytics_workspace" "ab_log_analytics" {
    provider                      = azurerm.provider-log-analytics
    count                         = (var.app_service_object.log_analytics != null && var.app_service_object.log_analytics != "") ? 1 : 0

    name                          = var.app_service_object.log_analytics
    resource_group_name           = var.app_service_object.log_analytics_rg

}

resource "azurerm_monitor_diagnostic_setting" "ab_ase_monitor" {
    provider                      = azurerm.provider-log-analytics
    count                         = (var.app_service_object.log_analytics != null && var.app_service_object.log_analytics != "") ? 1 : 0
    
    name                          = "diagnostics-${var.app_service_object.ase_name}"
    target_resource_id            = azurerm_app_service_environment.app_service_environment.id
    
    log_analytics_workspace_id    = data.azurerm_log_analytics_workspace.ab_log_analytics[0].id

    log {
        category = "AppServiceEnvironmentPlatformLogs"
        enabled  = true

        retention_policy {
            enabled = true
        }
    }
}