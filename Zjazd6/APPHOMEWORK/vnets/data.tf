data "azurerm_resource_group" "rg-hub-mf2" {
    provider = azurerm.provider-hub-env
    name = "rg-hub-mf2"
}

data "azurerm_resource_group" "rg-dev-mf2" {
    provider = azurerm.provider-dev-env
    name = "rg-dev-mf2"
}