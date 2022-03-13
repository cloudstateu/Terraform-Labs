resource "azurerm_management_group_policy_assignment" "pa-AKSDefenderSecurityProfileDeploy" {
  name                 = "pa-AKSDefenderSecDeploy"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-AKSDefenderSecurityProfileDeploy.id
  description          = "Assign azpoldef-AKSDefenderSecurityProfileDeploy policy to mg-root management group"
  display_name         = "pa-AKSDefenderSecDeploy"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "1.0.1",
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
