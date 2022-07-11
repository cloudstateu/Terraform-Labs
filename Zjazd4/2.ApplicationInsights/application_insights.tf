resource "azurerm_log_analytics_workspace" "log" {
  name                = local.log_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appinsights01" {
  name                = local.appi_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  workspace_id        = azurerm_log_analytics_workspace.log.id
  application_type    = "web"
}

output "instrumentation_key" {
  sensitive = true
  value     = azurerm_application_insights.appinsights01.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.appinsights01.app_id
}