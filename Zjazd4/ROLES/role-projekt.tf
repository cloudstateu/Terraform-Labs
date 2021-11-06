#
# TODO; zmiana resource providera
#
resource "azurerm_role_definition" "chm-dev-networkjoin" {
  name        = "chm-dev-networkjoin"
  #TODO
  provider    = azurerm.provider-dev-dev
  #TODO
  scope       = "/providers/Microsoft.Management/managementGroups/${data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id}"
  description = "chm-dev-networkjoin"

  permissions {
    actions   = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Portal/dashboards/read",
      "Microsoft.ResourceHealth/*/read",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/join/action",
      "Microsoft.Network/virtualNetworks/subnets/read",
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/write",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/routeTchmles/read"
    ]
    not_actions = []
  }
}

#
# Rola pozwala na modyfikację NSG w ramach konrektnego NSG, utworzonego na potrzeby danego projektu
# Rola nadawana na potrzeby danego projektu
#
resource "azurerm_role_definition" "chm-dev-nsgcontributor" {
  name        = "chm-dev-nsgcontributor"
  provider    = azurerm.provider-dev-dev
  #TODO
  scope       = "/subscriptions/${var.subscription-dev-id}"
  description = "chm-dev-nsgcontributor"

  permissions {
    actions   = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Portal/dashboards/read",
      "Microsoft.ResourceHealth/*/read",
      "Microsoft.Network/networkSecurityGroups/*"
      ]
    not_actions = []
  }

}

#Pozwala tworzyć grupy zasobów
resource "azurerm_role_definition" "chm-dev-rgcreator" {
  name        = "chm-dev-rgcreator"
  #TODO
  scope       = "/subscriptions/${var.subscription-dev-id}"
  description = "chm-dev-rgcreator"
  permissions {
    actions     = [
      "Microsoft.Resources/subscriptions/resourceGroups/*",
      "Microsoft.Authorization/roleAssignments/*"
    ]

    not_actions = [
    ]
  }
}
