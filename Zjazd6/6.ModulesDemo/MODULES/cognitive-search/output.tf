output "ab_search_service_id" {
    value = azurerm_search_service.ab_search_service.id
}

output "ab_search_service_primary_key" {
    value = azurerm_search_service.ab_search_service.primary_key
}

output "ab_search_service_secondary_key" {
    value = azurerm_search_service.ab_search_service.primary_key
}

output "ab_search_service_secondary_query_keys" {
    value = azurerm_search_service.ab_search_service.query_keys
}
