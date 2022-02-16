resource "azurerm_app_service_plan" "app-svc-plan" {
  provider            = azurerm.spoke
  name                = "svc-plan-${var.app_name}"
  location            = azurerm_resource_group.rg-spoke.location
  resource_group_name = azurerm_resource_group.rg-spoke.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app-svc-webapp" {
  provider            = azurerm.spoke
  name                = var.app_name
  location            = azurerm_resource_group.rg-spoke.location
  resource_group_name = azurerm_resource_group.rg-spoke.name
  app_service_plan_id = azurerm_app_service_plan.app-svc-plan.id

  app_settings = var.app_settings

  site_config {
    linux_fx_version = "DOCKER|${var.docker_image}"
    always_on        = true
  }
}
