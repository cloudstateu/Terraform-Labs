# -------- Azure Policy - Azure Kubernetes Service Clusters should have local authentication methods disabled ----------

resource "azurerm_policy_definition" "azpoldef-DisableLocalAccounts" {
  name                  = "azpoldef-DisableLocalAccounts"
  display_name          = "azpoldef-DisableLocalAccounts"
  policy_type           = "Custom"
  mode                  = "Indexed"
  description           = "Disabling local authentication methods improves security by ensuring that Azure Kubernetes Service Clusters should exclusively require Azure Active Directory identities for authentication. Learn more at: https://aka.ms/aks-disable-local-accounts."
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
            "field": "Microsoft.ContainerService/managedClusters/disableLocalAccounts",
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
