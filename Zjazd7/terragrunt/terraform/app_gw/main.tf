resource "azurerm_resource_group" "rg" {
  provider = azurerm.app_gw
  name     = "rg-app-gw"
  location = var.location
}

resource "azurerm_public_ip" "pip" {
  provider            = azurerm.app_gw
  name                = "app-gw-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  ip_version          = "IPv4"
}

resource "azurerm_application_gateway" "app-gw" {
  provider            = azurerm.app_gw
  name                = "app-gw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "subnet"
    subnet_id = azurerm_subnet.sbn-app-gw.id
  }

  frontend_port {
    name = "http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "ip_config"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  dynamic backend_address_pool {
    for_each = var.apps
    content {
      name  = backend_address_pool.key
      fqdns = [backend_address_pool.value.backend_address]
    }
  }

  dynamic http_listener {
    for_each = var.apps

    content {
      name                           = http_listener.key
      frontend_ip_configuration_name = "ip_config"
      frontend_port_name             = "http"
      protocol                       = "Http"
      host_name                      = "${http_listener.value.name}.${var.domain_name}"
    }
  }

  dynamic probe {
    for_each = var.apps
    content {
      name                                      = probe.key
      protocol                                  = "Http"
      path                                      = probe.value.probe_path
      interval                                  = 30
      timeout                                   = 120
      unhealthy_threshold                       = 3
      pick_host_name_from_backend_http_settings = true
    }
  }

  dynamic backend_http_settings {
    for_each = var.apps
    content {
      name                                = backend_http_settings.key
      probe_name                          = backend_http_settings.key
      cookie_based_affinity               = "Disabled"
      port                                = 80
      protocol                            = "Http"
      request_timeout                     = 120
      pick_host_name_from_backend_address = true
    }
  }

  dynamic request_routing_rule {
    for_each = var.apps
    content {
      name                       = request_routing_rule.key
      http_listener_name         = request_routing_rule.key
      rule_type                  = "Basic"
      backend_address_pool_name  = request_routing_rule.key
      backend_http_settings_name = request_routing_rule.key
    }
  }
}

resource "azurerm_dns_a_record" "a_records" {
  provider            = azurerm.app_gw
  for_each            = var.apps
  name                = each.value.name
  resource_group_name = "main"
  ttl                 = 0
  zone_name           = var.domain_name
  target_resource_id  = azurerm_public_ip.pip.id
}
