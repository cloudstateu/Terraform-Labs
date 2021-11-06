resource "azurerm_user_assigned_identity" "aks-dev-01-ui" {
  name                = "aks-dev-01-ui"
  location            = azurerm_resource_group.dev-prolab-rg[0].location
  resource_group_name = azurerm_resource_group.dev-prolab-rg[0].name
}

resource "azurerm_role_assignment" "aks-dev-01-ui-ra" {
  scope                = azurerm_private_dns_zone.akszone.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks-dev-01-ui.principal_id
}

# resource "azurerm_role_assignment" "aksclusterspn2aks-cluster-manager" {
#   depends_on = [
#     azurerm_resource_group.dev-prolab-rg[0]
#   ]
#   #scope                = data.azurerm_subscription.primary.id
#   #scope = "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8/resourceGroups/dev-prolab0-rg"
#   scope = azurerm_resource_group.dev-prolab-rg[0].id
#   role_definition_name = azurerm_role_definition.aks-cluster-manager.name
#   principal_id         = azurerm_user_assigned_identity.aks-dev-01-ui.principal_id
#   #azuread_service_principal.aksclusterinstallspn.object_id
# }

resource "azurerm_role_assignment" "aksclusterspn2aksdevnet-cluster-manager_akscluster" {
  depends_on = [
    azurerm_resource_group.dev-net-rg
  ]
  scope = data.azurerm_subscription.primary.id
  #scope = "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8/resourceGroups/dev-prolab0-rg"
  #scope = azurerm_resource_group.dev-prolab-rg[0].id
  role_definition_name = azurerm_role_definition.aks-cluster-manager_akscluster.name
  principal_id         = azurerm_user_assigned_identity.aks-dev-01-ui.principal_id
  #azuread_service_principal.aksclusterinstallspn.object_id
}

resource "azurerm_role_assignment" "aksclusterspn2aksdevnet-cluster-manager_network" {
  depends_on = [
    azurerm_resource_group.dev-net-rg
  ]
  #scope                = data.azurerm_subscription.primary.id
  scope = "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  #scope = azurerm_resource_group.dev-net-rg.id
  role_definition_name = azurerm_role_definition.aks-cluster-manager_network.name
  principal_id         = azurerm_user_assigned_identity.aks-dev-01-ui.principal_id
  #azuread_service_principal.aksclusterinstallspn.object_id
}

resource "azurerm_role_assignment" "aksclusterspn2aksdevnet-cluster-manager_vm" {
  depends_on = [
    azurerm_resource_group.dev-net-rg
  ]

  scope = "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"

  role_definition_name = azurerm_role_definition.aks-cluster-manager_vm.name

  principal_id = azurerm_user_assigned_identity.aks-dev-01-ui.principal_id
}

output "rgid" {
  value = azurerm_resource_group.dev-prolab-rg[0].id
}