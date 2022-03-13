
locals {
  random_suffix_redis = substr(sha1(format("%s/%s",var.subscription_id,azurerm_resource_group.redis_rg.name)),0,5)
}

# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "pdw-redis1" {
  name                = format("%s%s","pdw-redis1",local.random_suffix_redis)
  location            = azurerm_resource_group.redis_rg.location
  resource_group_name = azurerm_resource_group.redis_rg.name
  capacity            = 2
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  subnet_id           = azurerm_subnet.redis-sub.id
  
  redis_configuration {
  }
}