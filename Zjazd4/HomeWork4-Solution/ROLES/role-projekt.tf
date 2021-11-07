#
# TODO; zmiana resource providera
#
resource "azurerm_role_definition" "mf-chm-dev-networkjoin" {
  name        = "mf-chm-dev-networkjoin"
  scope       = "/subscriptions/${var.subscription-id}"
  description = "mf-chm-dev-networkjoin"

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Portal/dashboards/read",
      "Microsoft.ResourceHealth/*/read",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/join/action",
      "Microsoft.Network/virtualNetworks/subnets/read",
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/write",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/routeTables/read"
    ]
    not_actions = []
  }
}

#
# Rola pozwala na modyfikację NSG w ramach konrektnego NSG, utworzonego na potrzeby danego projektu
# Rola nadawana na potrzeby danego projektu
#
resource "azurerm_role_definition" "mf-chm-dev-nsgcontributor" {
  name        = "mf-chm-dev-nsgcontributor"
  scope       = "/subscriptions/${var.subscription-id}"
  description = "mf-chm-dev-nsgcontributor"

  permissions {
    actions = [
      "Microsoft.Resources/deployments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Portal/dashboards/read",
      "Microsoft.ResourceHealth/*/read",
      "Microsoft.Network/networkSecurityGroups/*"
    ]
    not_actions = []
  }

}

#Pozwala tworzyć grupy zasobów
resource "azurerm_role_definition" "mf-chm-dev-rgcreator" {
  name        = "mf-chm-dev-rgcreator"
  scope       = "/subscriptions/${var.subscription-id}"
  description = "mf-chm-dev-rgcreator"
  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/*",
      "Microsoft.Authorization/roleAssignments/*"
    ]

    not_actions = [
    ]
  }
}
