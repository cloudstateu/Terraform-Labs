
resource "azurerm_app_service_plan" "app-serv-plan" {
  name                = "app-serv-plan"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app-service" {
  for_each = var.app_names
  name = each.value

  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  app_service_plan_id = azurerm_app_service_plan.app-serv-plan.id

  site_config {
    dotnet_framework_version = each.value == "mz-ntoebook-app" ? "v2.0" : "v4.0"
    scm_type                 = "LocalGit"
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