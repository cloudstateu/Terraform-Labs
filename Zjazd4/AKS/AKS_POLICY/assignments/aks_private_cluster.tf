resource "azurerm_management_group_policy_assignment" "pa-AKSPrivateCluster" {
  name                 = "pa-AKSPrivateCluster"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-AKSPrivateCluster.id
  description          = "Assign azpoldef-AKSPrivateCluster policy to mg-root management group"
  display_name         = "pa-AKSPrivateCluster"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "Audit"
      }
    }
  PARAMETERS
}
