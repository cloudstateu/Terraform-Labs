# -------- Azure Policy - Deploy - Configure diagnostic settings for Azure Kubernetes Service to Log Analytics workspace ----------

resource "azurerm_policy_definition" "azpoldef-DataConnectorsAzureKubernetes" {
  name                  = "azpoldef-DataConnectorsAzureKubernetes"
  display_name          = "azpoldef-DataConnectorsAzureKubernetes"
  policy_type           = "Custom"
  mode                  = "Indexed"
  description           = "Deploys the diagnostic settings for Azure Kubernetes Service to stream resource logs to a Log Analytics workspace."
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
          "roleDefinitionIds": [
            "/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa",
            "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"
          ],
          "existenceCondition": {
            "allOf": [
              {
                "field": "Microsoft.Insights/diagnosticSettings/logs.enabled",
                "equals": "True"
              },
              {
                "field": "Microsoft.Insights/diagnosticSettings/metrics.enabled",
                "equals": "True"
              },
              {
                "field": "Microsoft.Insights/diagnosticSettings/workspaceId",
                "equals": "[parameters('logAnalytics')]"
              }
            ]
          },
          "deployment": {
            "properties": {
              "mode": "incremental",
              "template": {
                "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                  "diagnosticsSettingNameToUse": {
                    "type": "string"
                  },
                  "resourceName": {
                    "type": "string"
                  },
                  "logAnalytics": {
                    "type": "string"
                  },
                  "location": {
                    "type": "string"
                  },
                  "AllMetrics": {
                    "type": "string"
                  },
                  "kube-apiserver": {
                    "type": "string"
                  },
                  "kube-audit": {
                    "type": "string"
                  },
                  "kube-controller-manager": {
                    "type": "string"
                  },
                  "kube-scheduler": {
                    "type": "string"
                  },
                  "cluster-autoscaler": {
                    "type": "string"
                  },
                  "kube-audit-admin": {
                    "type": "string"
                  },
                  "guard": {
                    "type": "string"
                  }
                },
                "variables": {},
                "resources": [
                  {
                    "type": "Microsoft.ContainerService/managedClusters/providers/diagnosticSettings",
                    "apiVersion": "2017-05-01-preview",
                    "name": "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('diagnosticsSettingNameToUse'))]",
                    "location": "[parameters('location')]",
                    "dependsOn": [],
                    "properties": {
                      "workspaceId": "[parameters('logAnalytics')]",
                      "metrics": [
                        {
                          "category": "AllMetrics",
                          "enabled": "[parameters('AllMetrics')]"
                        }
                      ],
                      "logs": [
                        {
                          "category": "kube-apiserver",
                          "enabled": "[parameters('kube-apiserver')]"
                        },
                        {
                          "category": "kube-audit",
                          "enabled": "[parameters('kube-audit')]"
                        },
                        {
                          "category": "kube-controller-manager",
                          "enabled": "[parameters('kube-controller-manager')]"
                        },
                        {
                          "category": "kube-scheduler",
                          "enabled": "[parameters('kube-scheduler')]"
                        },
                        {
                          "category": "cluster-autoscaler",
                          "enabled": "[parameters('cluster-autoscaler')]"
                        },
                        {
                          "category": "kube-audit-admin",
                          "enabled": "[parameters('kube-audit-admin')]"
                        },
                        {
                          "category": "guard",
                          "enabled": "[parameters('guard')]"
                        }
                      ]
                    }
                  }
                ],
                "outputs": {}
              },
              "parameters": {
                "diagnosticsSettingNameToUse": {
                  "value": "[parameters('diagnosticsSettingNameToUse')]"
                },
                "logAnalytics": {
                  "value": "[parameters('logAnalytics')]"
                },
                "location": {
                  "value": "[field('location')]"
                },
                "resourceName": {
                  "value": "[field('name')]"
                },
                "guard": {
                  "value": "[parameters('guard')]"
                },
                "AllMetrics": {
                  "value": "[parameters('AllMetrics')]"
                },
                "kube-apiserver": {
                  "value": "[parameters('kube-apiserver')]"
                },
                "kube-audit": {
                  "value": "[parameters('kube-audit')]"
                },
                "kube-scheduler": {
                  "value": "[parameters('kube-scheduler')]"
                },
                "kube-controller-manager": {
                  "value": "[parameters('kube-controller-manager')]"
                },
                "cluster-autoscaler": {
                  "value": "[parameters('cluster-autoscaler')]"
                },
                "kube-audit-admin": {
                  "value": "[parameters('kube-audit-admin')]"
                }
              }
            }
          }
        }
      }
    }
  POLICY_RULE

  parameters = <<PARAMETERS
    {
      "effect": {
        "type": "string",
        "defaultValue": "DeployIfNotExists",
        "allowedValues": [
          "DeployIfNotExists",
          "Disabled"
        ],
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        }
      },
      "diagnosticsSettingNameToUse": {
        "type": "String",
        "metadata": {
          "displayName": "Setting name",
          "description": "Name of the diagnostic settings."
        },
        "defaultValue": "AzureKubernetesDiagnosticsLogsToWorkspace"
      },
      "logAnalytics": {
        "type": "String",
        "metadata": {
          "displayName": "Log Analytics workspace",
          "description": "Specify the Log Analytics workspace the Azure Kubernetes Service should be connected to",
          "strongType": "omsWorkspace",
          "assignPermissions": true
        }
      },
      "AllMetrics": {
        "type": "String",
        "metadata": {
          "displayName": "AllMetrics - Enabled",
          "description": "Whether to stream AllMetrics logs to the Log Analytics workspace - True or False"
        },
        "allowedValues": [
          "True",
          "False"
        ],
        "defaultValue": "True"
      },
      "kube-apiserver": {
        "type": "String",
        "metadata": {
          "displayName": "kube-apiserver - Enabled",
          "description": "Whether to stream kube-apiserver logs to the Log Analytics workspace - True or False"
        },
        "allowedValues": [
          "True",
          "False"
        ],
        "defaultValue": "True"
      },
      "kube-audit": {
        "type": "String",
        "metadata": {
          "displayName": "kube-audit - Enabled",
          "description": "Whether to stream kube-audit logs to the Log Analytics workspace - True or False"
        },
        "allowedValues": [
          "True",
          "False"
        ],
        "defaultValue": "True"
      },
      "kube-controller-manager": {
        "type": "String",
        "metadata": {
          "displayName": "kube-controller-manager - Enabled",
          "description": "Whether to stream kube-controller-manager logs to the Log Analytics workspace - True or False"
        },
        "allowedValues": [
          "True",
          "False"
        ],
        "defaultValue": "True"
      },
      "kube-scheduler": {
        "type": "String",
        "metadata": {
          "displayName": "kube-scheduler - Enabled",
          "description": "Whether to stream kube-scheduler logs to the Log Analytics workspace - True or False"
        },
        "allowedValues": [
          "True",
          "False"
        ],
        "defaultValue": "True"
      },
      "cluster-autoscaler": {
        "type": "String",
        "metadata": {
          "displayName": "cluster-autoscaler - Enabled",
          "description": "Whether to stream cluster-autoscaler logs to the Log Analytics workspace - True or False"
        },
        "allowedValues": [
          "True",
          "False"
        ],
        "defaultValue": "True"
      },
      "kube-audit-admin": {
        "type": "String",
        "metadata": {
          "displayName": "kube-audit-admin - Enabled",
          "description": "Whether to stream kube-audit-admin logs to the Log Analytics workspace - True or False"
        },
        "allowedValues": [
          "True",
          "False"
        ],
        "defaultValue": "True"
      },
      "guard": {
        "type": "String",
        "metadata": {
          "displayName": "guard - Enabled",
          "description": "Whether to stream guard logs to the Log Analytics workspace - True or False"
        },
        "allowedValues": [
          "True",
          "False"
        ],
        "defaultValue": "True"
      }
    }
  PARAMETERS
}