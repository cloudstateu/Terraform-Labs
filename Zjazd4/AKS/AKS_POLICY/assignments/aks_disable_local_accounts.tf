resource "azurerm_management_group_policy_assignment" "pa-DisableLocalAccounts" {
  name                 = "pa-DisableLocalAccounts"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-DisableLocalAccounts.id
  description          = "Assign azpoldef-DisableLocalAccounts policy to mg-root management group"
  display_name         = "pa-DisableLocalAccounts"
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
