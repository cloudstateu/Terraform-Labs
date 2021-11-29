
resource "azurerm_log_analytics_workspace" "loganal01" {
  name                = "loganal01"
  location            = data.azurerm_resource_group.dev-prolab.location
  resource_group_name = data.azurerm_resource_group.dev-prolab.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb      = -1
}

resource "azurerm_log_analytics_cluster" "loganal01cluster" {
  name                = "loganal01cluster"
  location            = data.azurerm_resource_group.dev-prolab.location
  resource_group_name = data.azurerm_resource_group.dev-prolab.name

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_application_insights" "appinsights01" {
  name                = "appinsights01"
  location            = data.azurerm_resource_group.dev-prolab.location
  resource_group_name = data.azurerm_resource_group.dev-prolab.name
  workspace_id        = azurerm_log_analytics_workspace.loganal01.id
  application_type    = "web"
}

output "instrumentation_key" {
  value = azurerm_application_insights.appinsights01.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.appinsights01.app_id
}

resource "azurerm_monitor_private_link_scope" "ampls01" {
  name                = "ampls01"
  resource_group_name = azurerm_resource_group.dev-prolab.name
}

resource "azurerm_monitor_private_link_scoped_service" "ampls01linkedscopeservice" {
  name                = "ampls01linkedscopeservice"
  resource_group_name = data.azurerm_resource_group.dev-prolab.name
  scope_name          = azurerm_monitor_private_link_scope.ampls01.name
  linked_resource_id  = azurerm_application_insights.appinsights01.id
}

                   