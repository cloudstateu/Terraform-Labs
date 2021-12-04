resource "azurerm_kubernetes_cluster" "aks-dev-01" {
  name                = "aks-dev-01"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  
  dns_prefix          = "aks-dev-01"

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
  }

   identity {
     type                      = "SystemAssigned"
   }

   addon_profile {

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.loganal01.id
    }

  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks-dev-01.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks-dev-01.kube_config_raw
  sensitive = true
}

data "azurerm_monitor_diagnostic_categories" "azurerm_monitor_diagnostic_setting_aks" {
  resource_id = azurerm_kubernetes_cluster.aks-dev-01.id
}

output "azurerm_monitor_diagnostic_setting_aks_logs" {
   value = data.azurerm_monitor_diagnostic_categories.azurerm_monitor_diagnostic_setting_aks.logs
}

output "azurerm_monitor_diagnostic_setting_aks_metrics" {
   value = data.azurerm_monitor_diagnostic_categories.azurerm_monitor_diagnostic_setting_aks.metrics
}
