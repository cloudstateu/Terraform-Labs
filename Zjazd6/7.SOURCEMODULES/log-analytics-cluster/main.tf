data "azurerm_resource_group" "ab_resource_group" {
    name                            = var.rg_name
}

resource "azurerm_log_analytics_cluster" "ab_log_analytics_cluster" {
    name                    = var.name
    location                = data.azurerm_resource_group.ab_resource_group.location
    resource_group_name     = data.azurerm_resource_group.ab_resource_group.name
    size_gb                 = var.size_gb

    identity {
        type = "SystemAssigned"
    }

    lifecycle {
        ignore_changes = [
            tags
        ]
    }
}

resource "azurerm_log_analytics_cluster_customer_managed_key" "ab_log_analytics_cluster_customer_managed_key" {
    count                    = (var.custom_key == true) ? 1 : 0
    log_analytics_cluster_id = azurerm_log_analytics_cluster.ab_log_analytics_cluster.id
    key_vault_key_id         = var.key_id
}