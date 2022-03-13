data "azurerm_resource_group" "rg" {
  name = var.resource-group-name
}

resource "azurerm_redis_cache" "current" {
  name                = var.redis-name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  capacity            = var.redis-capacity
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  subnet_id = var.redis-subnet-id

  redis_configuration {
  }
}
