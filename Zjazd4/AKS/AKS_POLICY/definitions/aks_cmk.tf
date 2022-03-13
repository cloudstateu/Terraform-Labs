# -------- Azure Policy - Both operating systems and data disks in Azure Kubernetes Service clusters should be encrypted by customer-managed keys ----------

resource "azurerm_policy_definition" "azpoldef-CMK" {
  name                  = "azpoldef-CMK"
  display_name          = "azpoldef-CMK"
  policy_type           = "Custom"
  mode                  = "Indexed"
  description           = "Encrypting OS and data disks using customer-managed keys provides more control and greater flexibility in key management. This is a common requirement in many regulatory and industry compliance standards."
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
            "anyOf": [
              {
                "field": "Microsoft.ContainerService/managedClusters/diskEncryptionSetID",
                "exists": "False"
              },
              {
                "field": "Microsoft.ContainerService/managedClusters/diskEncryptionSetID",
                "equals": ""
              }
            ]
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
          "description": "'Audit' allows a non-compliant resource to be created or updated, but flags it as non-compliant. 'Deny' blocks the non-compliant resource creation or update. 'Disabled' turns off the policy."
        }
      }
    }
  PARAMETERS
}
