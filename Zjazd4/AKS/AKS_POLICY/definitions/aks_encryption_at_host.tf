# -------- Azure Policy - Temp disks and cache for agent node pools in Azure Kubernetes Service clusters should be encrypted at host ----------

resource "azurerm_policy_definition" "azpoldef-AKSEncryptionAtHost" {
  name                  = "azpoldef-AKSEncryptionAtHost"
  display_name          = "azpoldef-AKSEncryptionAtHost"
  policy_type           = "Custom"
  mode                  = "Indexed"
  description           = "To enhance data security, the data stored on the virtual machine (VM) host of your Azure Kubernetes Service nodes VMs should be encrypted at rest. This is a common requirement in many regulatory and industry compliance standards."
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
            "count": {
              "field": "Microsoft.ContainerService/managedClusters/agentPoolProfiles[*]",
              "where": {
                "anyOf": [
                  {
                    "field": "Microsoft.ContainerService/managedClusters/agentPoolProfiles[*].enableEncryptionAtHost",
                    "exists": "False"
                  },
                  {
                    "field": "Microsoft.ContainerService/managedClusters/agentPoolProfiles[*].enableEncryptionAtHost",
                    "equals": ""
                  },
                  {
                    "field": "Microsoft.ContainerService/managedClusters/agentPoolProfiles[*].enableEncryptionAtHost",
                    "equals": "false"
                  }
                ]
              }
            },
            "greater": 0
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
