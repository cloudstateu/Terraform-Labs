resource "azurerm_management_group_policy_assignment" "pa-AKSAADAdminGroup" {
  name                 = "pa-AKSAADAdminGroup"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-AKSAADAdminGroup.id
  description          = "Assign azpoldef-AKSAADAdminGroup policy to mg-root management group"
  display_name         = "pa-AKSAADAdminGroup"
  enforce              = "false"

  identity {
    type = "SystemAssigned"
  }
  location = "West Europe"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  #TODO - Add admin group object ids
  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "DeployIfNotExists"
      },
      "adminGroupObjectIDs": {
        "value": [
          "__EXAMPLE__"
        ]
      }
    }
  PARAMETERS
}
