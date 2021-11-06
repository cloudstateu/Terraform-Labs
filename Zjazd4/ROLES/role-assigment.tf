resource "azurerm_role_assignment" "user-cluster-role" {

  scope                = data.azurerm_subscription.primary.id
  #scope = "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8/resourceGroups/dev-prolab0-rg"
  #scope = azurerm_resource_group.dev-prolab-rg[0].id
  role_definition_name = azurerm_role_definition.aks-cluster-manager_akscluster.name
  
  principal_id         = data.azuread_user.mifurm.principal_id

  #principal_id         = azurerm_user_assigned_identity.aks-dev-01-ui.principal_id

  #azuread_service_principal.aksclusterinstallspn.object_id
}