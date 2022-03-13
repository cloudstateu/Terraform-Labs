# -------- Azure Policy - Azure Kubernetes Service Private Clusters should be enabled ----------

resource "azurerm_policy_definition" "azpoldef-AKSPrivateCluster" {
  name                  = "azpoldef-AKSPrivateCluster"
  display_name          = "azpoldef-AKSPrivateCluster"
  policy_type           = "Custom"
  mode                  = "Indexed"
  description           = "Enable the private cluster feature for your Azure Kubernetes Service cluster to ensure network traffic between your API server and your node pools remains on the private network only. This is a common requirement in many regulatory and industry compliance standards."
  management_group_name = data.azurerm_management_group.mg-root.name

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.ContainerService/managedClusters"
          },
          {
            "field": "Microsoft.ContainerService/managedClusters/apiServerAccessProfile.enablePrivateCluster",
            "notEquals": true
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]"
      }
    }
  POLICY_RULE

  parameters = <<PARAMETERS
    {
      "effect": {
        "type": "String",
        "defaultValue": "Audit",
        "allowedValues": [
          "Audit",
          "Deny",
          "Disabled"
        ],
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy."
        }
      }
    }
  PARAMETERS
}


