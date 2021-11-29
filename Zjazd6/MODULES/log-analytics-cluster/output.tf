output "id" {
    value = azurerm_log_analytics_cluster.ab_log_analytics_cluster.id
}

output "principal_id" {
    value = azurerm_log_analytics_cluster.ab_log_analytics_cluster.identity.0.principal_id
}