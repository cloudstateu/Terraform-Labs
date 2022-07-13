resource "azurerm_role_definition" "role-rgcreator" {
  name        = local.role_rgcreator_name
  scope       = data.azurerm_resource_group.rg.id
  description = "Rola pozwalająca na zarządzanie grupami zasobów"

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/*",
      "Microsoft.Authorization/roleAssignments/*"
    ]

    not_actions = [
    ]
  }
}

resource "azurerm_role_definition" "role-nsgcontributor" {
  name        = local.role_nsgcontributor_name
  scope       = data.azurerm_resource_group.rg.id
  description = "Rola pozwalająca na modyfikację NSG w ramach konrektnego NSG, utworzonego na potrzeby danego projektu"

  permissions {
    actions = [
      "Microsoft.Resources/deployments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Portal/dashboards/read",
      "Microsoft.ResourceHealth/*/read",
      "Microsoft.Network/networkSecurityGroups/*"
    ]
    not_actions = [
    ]
  }
}