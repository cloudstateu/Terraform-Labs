resource "azurerm_management_group_policy_assignment" "pa-CMK" {
  name                 = "pa-CMK"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-CMK.id
  description          = "Assign azpoldef-CMK policy to mg-root management group"
  display_name         = "pa-CMK"
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
