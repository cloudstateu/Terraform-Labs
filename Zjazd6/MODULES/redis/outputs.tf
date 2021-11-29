output "redis_id" {
    value = azurerm_redis_cache.redis_cache.id
}

output "redis_hostname" {
    value = azurerm_redis_cache.redis_cache.hostname
}

output "redis_ssl_port" {
    value = azurerm_redis_cache.redis_cache.ssl_port
}

output "redis_port" {
    value = azurerm_redis_cache.redis_cache.port
}

output "redis_primary_access_key" {
    value = azurerm_redis_cache.redis_cache.primary_access_key
}

output "redis_secondary_access_key" {
    value = azurerm_redis_cache.redis_cache.secondary_access_key
}

output "redis_primary_connection_string" {
    value = azurerm_redis_cache.redis_cache.primary_connection_string
}

output "redis_secondary_connection_string" {
    value = azurerm_redis_cache.redis_cache.secondary_connection_string
}

