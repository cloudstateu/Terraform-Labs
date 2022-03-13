resource "azurerm_management_group_policy_assignment" "pa-AllowedExternalIPs" {
  name                 = "pa-AllowedExternalIPs"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-AllowedExternalIPs.id
  description          = "Assign azpoldef-AllowedExternalIPs policy to mg-root management group"
  display_name         = "pa-AllowedExternalIPs"
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
        "value": "audit"
      },
      "excludedNamespaces": {
        "value": [
          "kube-system",
          "gatekeeper-system",
          "azure-arc"
        ]
      },
      "namespaces": {
        "value": [
        ]
      },
      "labelSelector": {
        "value": {
          "matchLabels": {
            "key": "value"
          },
          "matchExpressions": [
            {
              "key": "label-key",
              "operator": "In",
              "values": [
                "value1",
                "value2"
              ]
            }
          ]
        }
      },
      "allowedExternalIPs": {
        "value": [
        ]
      }
    }
  PARAMETERS
}
