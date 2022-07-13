resource "azurerm_role_assignment" "user01-role-assigment1" {
  scope              = data.azurerm_resource_group.rg.id
  role_definition_id = azurerm_role_definition.role-rgcreator.role_definition_resource_id
  principal_id       = azuread_user.user01.object_id
}

resource "azurerm_role_assignment" "user01-role-assigment2" {
  scope              = data.azurerm_resource_group.rg.id
  role_definition_id = azurerm_role_definition.role-nsgcontributor.role_definition_resource_id
  principal_id       = azuread_user.user01.object_id
}