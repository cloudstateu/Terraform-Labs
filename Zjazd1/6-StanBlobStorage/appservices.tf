resource "azurerm_service_plan" "app-serv-plan" {
  name                = "app-serv-plan"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  sku_name            = "S1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "app-service" {
  for_each = var.app_names
  name     = each.value

  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  service_plan_id     = azurerm_service_plan.app-serv-plan.id

  site_config {
    application_stack {
      dotnet_version = each.value == "mz-ntoebook-app" ? "3.1" : "5.0"
    }
  }

  tags = {
    creation_date = formatdate("DD-MM-YY", timestamp())
  }

  lifecycle {
    ignore_changes = [
      tags,
      app_settings
    ]
  }
}
