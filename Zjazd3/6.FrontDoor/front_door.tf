//noinspection MissingProperty
resource "azurerm_frontdoor" "frontdoor" {
  name                = local.frontdoor_name
  resource_group_name = data.azurerm_resource_group.rg.name

  backend_pool {
    name                = "main"
    health_probe_name   = "main"
    load_balancing_name = "main"

    backend {
      address     = azurerm_linux_web_app.app.default_hostname
      host_header = azurerm_linux_web_app.app.default_hostname
      http_port   = 80
      https_port  = 443
    }
  }

  backend_pool_health_probe {
    name                = "main"
    path                = "/"
    protocol            = "Https"
    probe_method        = "HEAD"
    interval_in_seconds = "30"
  }

  backend_pool_load_balancing {
    name = "main"
  }

  frontend_endpoint {
    name      = "main"
    host_name = "${local.frontdoor_name}.azurefd.net"
  }

  routing_rule {
    name               = "main"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["main"]

    forwarding_configuration {
      backend_pool_name = "main"
    }
  }
}
