# -------- Azure Policy - Azure Kubernetes Service clusters should have Defender profile enabled ----------

resource "azurerm_policy_definition" "azpoldef-AKSDefenderSecurityProfileDeploy" {
  name                  = "azpoldef-AKSDefenderSecurityProfileDeploy"
  display_name          = "azpoldef-AKSDefenderSecurityProfileDeploy"
  policy_type           = "Custom"
  mode                  = "Indexed"
  description           = "Microsoft Defender for Containers provides cloud-native Kubernetes security capabilities including environment hardening, workload protection, and run-time protection. When you enable the SecurityProfile.AzureDefender on your Azure Kubernetes Service cluster, an agent is deployed to your cluster to collect security event data. Learn more about Microsoft Defender for Containers in https://docs.microsoft.com/azure/security-center/defender-for-kubernetes-introduction"
  management_group_name = data.azurerm_management_group.mg-root.name

  metadata = <<METADATA
    {
      "version": "1.0.1",
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
            "field": "Microsoft.ContainerService/managedClusters/securityProfile.azureDefender.enabled",
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
        "type": "string",
        "defaultValue": "Audit",
        "allowedValues": [
          "Audit",
          "Disabled"
        ],
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        }
      }
    }
  PARAMETERS
}
