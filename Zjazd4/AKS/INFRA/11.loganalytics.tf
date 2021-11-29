resource "azurerm_log_analytics_workspace" "loganal01" {
  name                = "loganal01"
  location            = azurerm_resource_group.dev-prolab-rg[0].location
  resource_group_name = azurerm_resource_group.dev-prolab-rg[0].name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

