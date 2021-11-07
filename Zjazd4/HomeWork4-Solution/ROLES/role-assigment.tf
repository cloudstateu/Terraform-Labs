data "azuread_user" "user01" {
  user_principal_name = "user01@michalfurmankiewiczhotmail.onmicrosoft.com"
}

resource "azurerm_role_assignment" "user-cluster-role" {
  scope                = "/subscriptions/${var.subscription-id}"
  role_definition_name = azurerm_role_definition.mf-chm-dev-rgcreator.name
  principal_id         = data.azuread_user.user01.object_id
}

resource "azurerm_role_assignment" "user01-nsgcontributor" {
  scope                = "/subscriptions/${var.subscription-id}/resourceGroups/rg-jenkins"
  role_definition_name = azurerm_role_definition.mf-chm-dev-nsgcontributor.name
  principal_id         = data.azuread_user.user01.object_id
}

#resourceGroups/rg-jenkins

