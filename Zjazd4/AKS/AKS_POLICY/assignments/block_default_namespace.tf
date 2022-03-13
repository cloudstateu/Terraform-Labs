resource "azurerm_management_group_policy_assignment" "pa-BlockDefaultNamespace" {
  name                 = "pa-BlockDefaultNamespace"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-BlockDefaultNamespace.id
  description          = "Assign azpoldef-BlockDefaultNamespace policy to mg-root management group"
  display_name         = "pa-BlockDefaultNamespace"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "2.1.2",
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
      }
    }
  PARAMETERS
}
