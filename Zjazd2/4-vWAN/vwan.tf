resource "azurerm_virtual_wan" "vwan" {
  name                = "vwan"
  resource_group_name = data.azurerm_resource_group.main_rg.name
  location            = data.azurerm_resource_group.main_rg.location
}