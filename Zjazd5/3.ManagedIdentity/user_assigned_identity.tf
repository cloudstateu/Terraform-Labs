resource "azurerm_user_assigned_identity" "vm-identity" {
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  name                = local.user_assigned_identity_name
}