# -------- Azure Policy - Resource logs in Azure Kubernetes Service should be enabled ----------

resource "azurerm_policy_definition" "azpoldef-KubernetesAuditDiagnosticLog" {
  name                  = "azpoldef-KubernetesAuditDiagnosticLog"
  display_name          = "azpoldef-KubernetesAuditDiagnosticLog"
  policy_type           = "Custom"
  mode                  = "Indexed"
  description           = "Azure Kubernetes Service's resource logs can help recreate activity trails when investigating security incidents. Enable it to make sure the logs will exist when needed."
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
        "field": "type",
        "equals": "Microsoft.ContainerService/managedClusters"
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "type": "Microsoft.Insights/diagnosticSettings",
          "existenceCondition": {
            "count": {
              "field": "Microsoft.Insights/diagnosticSettings/logs[*]",
              "where": {
                "anyOf": [
                  {
                    "allOf": [
                      {
                        "field": "Microsoft.Insights/diagnosticSettings/logs[*].retentionPolicy.enabled",
                        "equals": "true"
                      },
                      {
                        "anyOf": [
                          {
                            "field": "Microsoft.Insights/diagnosticSettings/logs[*].retentionPolicy.days",
                            "equals": "0"
                          },
                          {
                            "value": "[padLeft(current('Microsoft.Insights/diagnosticSettings/logs[*].retentionPolicy.days'), 3, '0')]",
                            "greaterOrEquals": "[padLeft(parameters('requiredRetentionDays'), 3, '0')]"
                          }
                        ]
                      },
                      {
                        "field": "Microsoft.Insights/diagnosticSettings/logs.enabled",
                        "equals": "true"
                      }
                    ]
                  },
                  {
                    "allOf": [
                      {
                        "field": "Microsoft.Insights/diagnosticSettings/logs.enabled",
                        "equals": "true"
                      },
                      {
                        "anyOf": [
                          {
                            "field": "Microsoft.Insights/diagnosticSettings/logs[*].retentionPolicy.enabled",
                            "notEquals": "true"
                          },
                          {
                            "field": "Microsoft.Insights/diagnosticSettings/storageAccountId",
                            "exists": false
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            },
            "greaterOrEquals": 1
          }
        }
      }
    }
  POLICY_RULE

  parameters = <<PARAMETERS
    {
      "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        },
        "allowedValues": [
          "AuditIfNotExists",
          "Disabled"
        ],
        "defaultValue": "AuditIfNotExists"
      },
      "requiredRetentionDays": {
        "type": "String",
        "metadata": {
          "displayName": "Required retention (days)",
          "description": "The required resource logs retention (in days)"
        },
        "defaultValue": "365"
      }
    }
  PARAMETERS
}
