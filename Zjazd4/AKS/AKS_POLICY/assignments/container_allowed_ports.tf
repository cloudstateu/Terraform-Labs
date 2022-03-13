resource "azurerm_management_group_policy_assignment" "pa-ContainerAllowedPorts" {
  name                 = "pa-ContainerAllowedPorts"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-ContainerAllowedPorts.id
  description          = "Assign azpoldef-ContainerAllowedPorts policy to mg-root management group"
  display_name         = "pa-ContainerAllowedPorts"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "6.1.2",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "deny"
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
      "allowedContainerPortsList": {
        "value" : [
        ]
      }
    }
  PARAMETERS
}
