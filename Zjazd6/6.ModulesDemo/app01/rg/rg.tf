resource "azurerm_resource_group" "module01-rg" {
  name     = "module01-rg"
  location = "West Europe"
}

resource "azurerm_resource_group" "monitoring-dev-rg" {
  provider = azurerm.provider-devenv-sub
  name     = "monitoring-dev-rg"
  location = "West Europe"
}
