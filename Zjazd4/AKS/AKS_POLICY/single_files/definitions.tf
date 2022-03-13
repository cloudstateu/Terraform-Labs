# -------- Azure Policy - Configure AAD integrated Azure Kubernetes Service Clusters with required Admin Group Access ----------

resource "azurerm_policy_definition" "azpoldef-AKSAADAdminGroup" {
  name                  = "azpoldef-AKSAADAdminGroup"
  display_name          = "azpoldef-AKSAADAdminGroup"
  policy_type           = "Custom"
  mode                  = "Indexed"
  description           = "Ensure to improve cluster security by centrally govern Administrator access to Azure Active Directory integrated AKS clusters."
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
            "field": "Microsoft.ContainerService/managedClusters/aadProfile",
            "exists": true
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "type": "Microsoft.ContainerService/managedClusters",
          "name": "[field('name')]",
          "roleDefinitionIds": [
            "/providers/Microsoft.Authorization/roleDefinitions/ed7f3fbd-7b88-4dd4-9017-9adb7ce333f8"
          ],
          "existenceCondition": {
            "allOf": [
              {
                "count": {
                  "field": "Microsoft.ContainerService/managedClusters/aadProfile.adminGroupObjectIDs[*]",
                  "where": {
                    "field": "Microsoft.ContainerService/managedClusters/aadProfile.adminGroupObjectIDs[*]",
                    "in": "[parameters('adminGroupObjectIDs')]"
                  }
                },
                "equals": "[length(parameters('adminGroupObjectIDs'))]"
              },
              {
                "count": {
                    "field": "Microsoft.ContainerService/managedClusters/aadProfile.adminGroupObjectIDs[*]"
                },
                "equals": "[length(parameters('adminGroupObjectIDs'))]"
              }
            ]
          },
          "deployment": {
            "properties": {
              "mode": "incremental",
              "template": {
                "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                    "clusterName": {
                      "type": "string"
                    },
                    "clusterResourceGroupName": {
                      "type": "string"
                    },
                    "adminGroupObjectIDs": {
                      "type": "array"
                    }
                  },
                  "variables": {
                    "clusterGetDeploymentName": "[concat('PolicyDeployment-Get-', parameters('clusterName'))]",
                    "clusterUpdateDeploymentName": "[concat('PolicyDeployment-Update-', parameters('clusterName'))]"
                  },
                  "resources": [
                    {
                      "apiVersion": "2020-06-01",
                      "type": "Microsoft.Resources/deployments",
                      "name": "[variables('clusterGetDeploymentName')]",
                      "properties": {
                        "mode": "Incremental",
                        "template": {
                          "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
                          "contentVersion": "1.0.0.0",
                          "resources": [],
                          "outputs": {
                            "aksCluster": {
                              "type": "object",
                              "value": "[reference(resourceId(parameters('clusterResourceGroupName'), 'Microsoft.ContainerService/managedClusters', parameters('clusterName')), '2021-07-01', 'Full')]"
                            }
                          }
                        }
                      }
                    },
                    {
                      "apiVersion": "2020-06-01",
                      "type": "Microsoft.Resources/deployments",
                      "name": "[variables('clusterUpdateDeploymentName')]",
                      "properties": {
                        "mode": "Incremental",
                        "expressionEvaluationOptions": {
                          "scope": "inner"
                        },
                        "template": {
                          "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
                          "contentVersion": "1.0.0.0",
                          "parameters": {
                            "aksClusterName": {
                              "type": "string"
                            },
                            "aksClusterContent": {
                              "type": "object"
                            },
                            "adminGroupObjectIDs": {
                              "type": "array"
                            }
                          },
                          "resources": [
                            {
                              "apiVersion": "2021-07-01",
                              "type": "Microsoft.ContainerService/managedClusters",
                              "name": "[parameters('aksClusterName')]",
                              "location": "[parameters('aksClusterContent').location]",
                              "sku": "[parameters('aksClusterContent').sku]",
                              "tags": "[if(contains(parameters('aksClusterContent'), 'tags'), parameters('aksClusterContent').tags, json('null'))]",
                              "properties": {
                                "kubernetesVersion": "[parameters('aksClusterContent').properties.kubernetesVersion]",
                                "dnsPrefix": "[parameters('aksClusterContent').properties.dnsPrefix]",
                                "agentPoolProfiles": "[if(contains(parameters('aksClusterContent').properties, 'agentPoolProfiles'), parameters('aksClusterContent').properties.agentPoolProfiles, json('null'))]",
                                "linuxProfile": "[if(contains(parameters('aksClusterContent').properties, 'linuxProfile'), parameters('aksClusterContent').properties.linuxProfile, json('null'))]",
                                "windowsProfile": "[if(contains(parameters('aksClusterContent').properties, 'windowsProfile'), parameters('aksClusterContent').properties.windowsProfile, json('null'))]",
                                "servicePrincipalProfile": "[if(contains(parameters('aksClusterContent').properties, 'servicePrincipalProfile'), parameters('aksClusterContent').properties.servicePrincipalProfile, json('null'))]",
                                "addonProfiles": "[if(contains(parameters('aksClusterContent').properties, 'addonProfiles'), parameters('aksClusterContent').properties.addonProfiles, json('null'))]",
                                "nodeResourceGroup": "[parameters('aksClusterContent').properties.nodeResourceGroup]",
                                "enableRBAC": "[if(contains(parameters('aksClusterContent').properties, 'enableRBAC'), parameters('aksClusterContent').properties.enableRBAC, json('null'))]",
                                "enablePodSecurityPolicy": "[if(contains(parameters('aksClusterContent').properties, 'enablePodSecurityPolicy'), parameters('aksClusterContent').properties.enablePodSecurityPolicy, json('null'))]",
                                "networkProfile": "[if(contains(parameters('aksClusterContent').properties, 'networkProfile'), parameters('aksClusterContent').properties.networkProfile, json('null'))]",
                                "aadProfile": {
                                  "adminGroupObjectIds": "[parameters('adminGroupObjectIDs')]",
                                  "managed": "[if(contains(parameters('aksClusterContent').properties.aadProfile, 'managed'), parameters('aksClusterContent').properties.aadProfile.managed, json('null'))]",
                                  "enableAzureRBAC": "[if(contains(parameters('aksClusterContent').properties.aadProfile, 'enableAzureRBAC'), parameters('aksClusterContent').properties.aadProfile.enableAzureRBAC, json('null'))]",
                                  "tenantID": "[if(contains(parameters('aksClusterContent').properties.aadProfile, 'tenantID'), parameters('aksClusterContent').properties.aadProfile.tenantID, json('null'))]",
                                  "clientAppID": "[if(contains(parameters('aksClusterContent').properties.aadProfile, 'clientAppID'), parameters('aksClusterContent').properties.aadProfile.clientAppID, json('null'))]",
                                  "serverAppID": "[if(contains(parameters('aksClusterContent').properties.aadProfile, 'serverAppID'), parameters('aksClusterContent').properties.aadProfile.serverAppID, json('null'))]",
                                  "serverAppSecret": "[if(contains(parameters('aksClusterContent').properties.aadProfile, 'serverAppSecret'), parameters('aksClusterContent').properties.aadProfile.serverAppSecret, json('null'))]"
                                },
                                "autoScalerProfile": "[if(contains(parameters('aksClusterContent').properties, 'autoScalerProfile'), parameters('aksClusterContent').properties.autoScalerProfile, json('null'))]",
                                "autoUpgradeProfile": "[if(contains(parameters('aksClusterContent').properties, 'autoUpgradeProfile'), parameters('aksClusterContent').properties.autoUpgradeProfile, json('null'))]",
                                "apiServerAccessProfile": "[if(contains(parameters('aksClusterContent').properties, 'apiServerAccessProfile'), parameters('aksClusterContent').properties.apiServerAccessProfile, json('null'))]",
                                "diskEncryptionSetID": "[if(contains(parameters('aksClusterContent').properties, 'diskEncryptionSetID'), parameters('aksClusterContent').properties.diskEncryptionSetID, json('null'))]",
                                "disableLocalAccounts": "[if(contains(parameters('aksClusterContent').properties, 'disableLocalAccounts'), parameters('aksClusterContent').properties.disableLocalAccounts, json('null'))]",
                                "fqdnSubdomain": "[if(contains(parameters('aksClusterContent').properties, 'fqdnSubdomain'), parameters('aksClusterContent').properties.fqdnSubdomain, json('null'))]",
                                "httpProxyConfig": "[if(contains(parameters('aksClusterContent').properties, 'httpProxyConfig'), parameters('aksClusterContent').properties.httpProxyConfig, json('null'))]",
                                "podIdentityProfile": "[if(contains(parameters('aksClusterContent').properties, 'podIdentityProfile'), parameters('aksClusterContent').properties.podIdentityProfile, json('null'))]",
                                "privateLinkResources": "[if(contains(parameters('aksClusterContent').properties, 'privateLinkResources'), parameters('aksClusterContent').properties.privateLinkResources, json('null'))]",
                                "securityProfile": "[if(contains(parameters('aksClusterContent').properties, 'securityProfile'), parameters('aksClusterContent').properties.securityProfile, json('null'))]",
                                "identityProfile": "[if(contains(parameters('aksClusterContent').properties, 'identityProfile'), parameters('aksClusterContent').properties.identityProfile, json('null'))]"
                              }
                            }
                          ],
                          "outputs": {}
                        },
                        "parameters": {
                          "aksClusterName": {
                            "value": "[parameters('clusterName')]"
                          },
                          "aksClusterContent": {
                            "value": "[reference(variables('clusterGetDeploymentName')).outputs.aksCluster.value]"
                          },
                          "adminGroupObjectIDs": {
                            "value": "[parameters('adminGroupObjectIDs')]"
                          }
                        }
                      }
                    }
                  ]
              },
              "parameters": {
                  "clusterName": {
                      "value": "[field('name')]"
                  },
                  "clusterResourceGroupName": {
                      "value": "[resourceGroup().name]"
                  },
                  "adminGroupObjectIDs": {
                      "value": "[parameters('adminGroupObjectIDs')]"
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
        "type": "String",
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
      "adminGroupObjectIDs": {
        "type": "Array",
        "metadata": {
          "displayName": "AKS Administrator Group Object IDs",
          "description": "Array of the existing AKS Administrator Group Object ID to ensure administration access to the cluster. Empty array will remove all admin access."
        }
      }
    }
  PARAMETERS
}

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

# -------- Azure Policy - Azure Kubernetes Service clusters should have Defender profile enabled ----------

resource "azurerm_policy_definition" "azpoldef-AKSDefenderSecurityProfileAudit" {
  name                  = "azpoldef-AKSDefenderSecurityProfileAudit"
  display_name          = "azpoldef-AKSDefenderSecurityProfileAudit"
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
        "field": "type",
        "equals": "Microsoft.ContainerService/managedClusters"
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "type": "Microsoft.ContainerService/managedClusters",
          "deploymentScope": "subscription",
          "existenceCondition": {
            "field": "Microsoft.ContainerService/managedClusters/securityProfile.azureDefender.enabled",
            "equals": "true"
          },
          "roleDefinitionIds": [
            "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
            "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"
          ],
          "deployment": {
            "location": "westeurope",
            "properties": {
              "mode": "incremental",
              "parameters": {
                "clusterRegion": {
                  "value": "[field('location')]"
                },
                "clusterResourceId": {
                  "value": "[field('id')]"
                },
                "clusterName": {
                  "value": "[field('name')]"
                }
              },
              "template": {
                "$schema": "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                  "clusterRegion": {
                    "type": "string"
                  },
                  "clusterResourceId": {
                    "type": "string"
                  },
                  "clusterName": {
                    "type": "string"
                  }
                },
                "variables": {
                  "locationLongNameToShortMap": {
                    "australiacentral": "CAU",
                    "australiaeast": "EAU",
                    "australiasoutheast": "SEAU",
                    "brazilsouth": "CQ",
                    "canadacentral": "CCA",
                    "centralindia": "CIN",
                    "centralus": "CUS",
                    "eastasia": "EA",
                    "eastus": "EUS",
                    "eastus2": "EUS2",
                    "eastus2euap": "eus2p",
                    "germanywestcentral": "DEWC",
                    "francecentral": "PAR",
                    "japaneast": "EJP",
                    "koreacentral": "SE",
                    "northcentralus": "NCUS",
                    "northeurope": "NEU",
                    "norwayeast": "NOE",
                    "southafricanorth": "JNB",
                    "southcentralus": "SCUS",
                    "southeastasia": "SEA",
                    "swedencentral": "SEC",
                    "switzerlandnorth": "CHN",
                    "switzerlandwest": "CHW",
                    "uaenorth": "DXB",
                    "uksouth": "SUK",
                    "ukwest": "WUK",
                    "westcentralus": "WCUS",
                    "westeurope": "WEU",
                    "westus": "WUS",
                    "westus2": "WUS2",
                    "usgovvirginia": "USGV",
                    "usgovarizona": "USGA",
                    "usgovtexas": "USGT",
                    "chinaeast": "CNE",
                    "chinaeast2": "CNE2",
                    "chinawest": "CNW",
                    "chinawest2": "CNW2"
                  },
                  "locationCode": "[variables('locationLongNameToShortMap')[parameters('clusterRegion')]]",
                  "subscriptionId": "[subscription().subscriptionId]",
                  "defaultRGName": "[concat('DefaultResourceGroup-', variables('locationCode'))]",
                  "workspaceName": "[concat('DefaultWorkspace-', variables('subscriptionId'),'-', variables('locationCode'))]",
                  "deployDefaultAscResourceGroup": "[concat('deployDefaultAscResourceGroup-', uniqueString(deployment().name))]"
                },
                "resources": [
                  {
                    "type": "Microsoft.Resources/resourceGroups",
                    "name": "[variables('defaultRGName')]",
                    "apiVersion": "2019-05-01",
                    "location": "[parameters('clusterRegion')]"
                  },
                  {
                    "type": "Microsoft.Resources/deployments",
                    "name": "[variables('deployDefaultAscResourceGroup')]",
                    "apiVersion": "2020-06-01",
                    "resourceGroup": "[variables('defaultRGName')]",
                    "properties": {
                      "mode": "Incremental",
                      "expressionEvaluationOptions": {
                        "scope": "inner"
                      },
                      "parameters": {
                        "clusterRegion": {
                          "value": "[parameters('clusterRegion')]"
                        },
                        "workspaceName": {
                          "value": "[variables('workspaceName')]"
                        }
                      },
                      "template": {
                        "$schema": "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#",
                        "contentVersion": "1.0.0.0",
                        "parameters": {
                          "clusterRegion": {
                            "type": "string"
                          },
                          "workspaceName": {
                            "type": "string"
                          }
                        },
                        "variables": {},
                        "resources": [
                          {
                            "type": "Microsoft.OperationalInsights/workspaces",
                            "name": "[parameters('workspaceName')]",
                            "apiVersion": "2015-11-01-preview",
                            "location": "[parameters('clusterRegion')]",
                            "properties": {
                              "sku": {
                                "name": "pernode"
                              },
                              "retentionInDays": 30,
                              "features": {
                                "searchVersion": 1
                              }
                            }
                          }
                        ]
                      }
                    },
                    "dependsOn": [
                      "[resourceId('Microsoft.Resources/resourceGroups', variables('defaultRGName'))]"
                    ]
                  },
                  {
                    "type": "Microsoft.Resources/deployments",
                    "name": "[concat('securityprofile-deploy-', '-',  uniqueString(parameters('clusterResourceId')))]",
                    "apiVersion": "2020-10-01",
                    "subscriptionId": "[variables('subscriptionId')]",
                    "resourceGroup": "[split(parameters('clusterResourceId'),'/')[4]]",
                    "properties": {
                      "mode": "Incremental",
                      "expressionEvaluationOptions": {
                        "scope": "inner"
                      },
                      "parameters": {
                        "workspaceResourceId": {
                          "value": "[concat('/subscriptions/', variables('subscriptionId'), '/resourcegroups/', variables('defaultRGName'), '/providers/Microsoft.OperationalInsights/workspaces/', variables('workspaceName'))]"
                        },
                        "clusterResourceId": {
                          "value": "[parameters('clusterResourceId')]"
                        },
                        "clusterName": {
                          "value": "[parameters('clusterName')]"
                        },
                        "clusterRegion": {
                          "value": "[parameters('clusterRegion')]"
                        }
                      },
                      "template": {
                        "$schema": "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#",
                        "contentVersion": "1.0.0.0",
                        "parameters": {
                          "workspaceResourceId": {
                            "type": "string"
                          },
                          "clusterResourceId": {
                            "type": "string"
                          },
                          "clusterName": {
                            "type": "string"
                          },
                          "clusterRegion": {
                            "type": "string"
                          }
                        },
                        "resources": [
                          {
                            "type": "Microsoft.ContainerService/ManagedClusters",
                            "name": "[parameters('clusterName')]",
                            "apiVersion": "2021-07-01",
                            "location": "[parameters('clusterRegion')]",
                            "properties": {
                              "securityProfile": {
                                "azureDefender": {
                                  "enabled": true,
                                  "logAnalyticsWorkspaceResourceId": "[parameters('workspaceResourceId')]"
                                }
                              }
                            }
                          }
                        ]
                      }
                    },
                    "dependsOn": [
                      "[variables('deployDefaultAscResourceGroup')]"
                    ]
                  }
                ]
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
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        },
        "allowedValues": [
          "DeployIfNotExists",
          "Disabled"
        ],
        "defaultValue": "DeployIfNotExists"
      }
    }
  PARAMETERS
}

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

# -------- Azure Policy - Kubernetes cluster services should only use allowed external IPs ----------

resource "azurerm_policy_definition" "azpoldef-AllowedExternalIPs" {
  name                  = "azpoldef-AllowedExternalIPs"
  display_name          = "azpoldef-AllowedExternalIPs"
  policy_type           = "Custom"
  mode                  = "Microsoft.Kubernetes.Data"
  description           = "Use allowed external IPs to avoid the potential attack (CVE-2020-8554) in a Kubernetes cluster. For more information, see https://aka.ms/kubepolicydoc."
  management_group_name = data.azurerm_management_group.mg-root.name


  metadata = <<METADATA
    {
      "version": "3.0.2",
      "category": "Kubernetes"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "field": "type",
        "in": [
          "AKS Engine",
          "Microsoft.Kubernetes/connectedClusters",
          "Microsoft.ContainerService/managedClusters"
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "constraintTemplate": "https://store.policy.core.windows.net/kubernetes/allowed-external-ips/v1/template.yaml",
          "constraint": "https://store.policy.core.windows.net/kubernetes/allowed-external-ips/v1/constraint.yaml",
          "excludedNamespaces": "[parameters('excludedNamespaces')]",
          "namespaces": "[parameters('namespaces')]",
          "labelSelector": "[parameters('labelSelector')]",
          "values": {
            "allowedExternalIPs": "[parameters('allowedExternalIPs')]"
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
          "description": "'audit' allows a non-compliant resource to be created or updated, but flags it as non-compliant. 'deny' blocks the non-compliant resource creation or update. 'disabled' turns off the policy."
        },
        "allowedValues": [
          "audit",
          "deny",
          "disabled"
        ],
        "defaultValue": "audit"
      },
      "excludedNamespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace exclusions",
          "description": "List of Kubernetes namespaces to exclude from policy evaluation. Providing a value for this parameter is optional. System namespaces \"kube-system\", \"gatekeeper-system\" and \"azure-arc\" are always excluded by design."
        },
        "defaultValue": ["kube-system", "gatekeeper-system", "azure-arc"]
      },
      "namespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace inclusions",
          "description": "List of Kubernetes namespaces to only include in policy evaluation. An empty list means the policy is applied to all resources in all namespaces."
        },
        "defaultValue": []
      },
      "labelSelector": {
        "type": "object",
        "metadata": {
          "displayName": "Kubernetes label selector",
          "description": "Label query to select Kubernetes resources for policy evaluation. An empty label selector matches all Kubernetes resources."
        },
        "defaultValue": {},
        "schema": {
          "description": "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all resources.",
          "type": "object",
          "properties": {
            "matchLabels": {
              "description": "matchLabels is a map of {key,value} pairs.",
              "type": "object",
              "additionalProperties": {
                "type": "string"
              },
              "minProperties": 1
            },
            "matchExpressions": {
              "description": "matchExpressions is a list of values, a key, and an operator.",
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "key": {
                    "description": "key is the label key that the selector applies to.",
                    "type": "string"
                  },
                  "operator": {
                    "description": "operator represents a key's relationship to a set of values.",
                    "type": "string",
                    "enum": [
                      "In",
                      "NotIn",
                      "Exists",
                      "DoesNotExist"
                    ]
                  },
                  "values": {
                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty.",
                    "type": "array",
                    "items": {
                      "type": "string"
                    }
                  }
                },
                "required": [
                  "key",
                  "operator"
                ],
                "additionalProperties": false
              },
              "minItems": 1
            }
          },
          "additionalProperties": false
        }
      },
      "allowedExternalIPs": {
        "type": "Array",
        "metadata": {
          "displayName": "Allowed External IPs",
          "description": "List of External IPs that services are allowed to use. Empty array means all external IPs are disallowed."
        },
        "defaultValue": []
      }
    }
  PARAMETERS
}

# -------- Azure Policy - Kubernetes clusters should not use the default namespace ----------

resource "azurerm_policy_definition" "azpoldef-BlockDefaultNamespace" {
  name                  = "azpoldef-BlockDefaultNamespace"
  display_name          = "azpoldef-BlockDefaultNamespace"
  policy_type           = "Custom"
  mode                  = "Microsoft.Kubernetes.Data"
  description           = "Prevent usage of the default namespace in Kubernetes clusters to protect against unauthorized access for ConfigMap, Pod, Secret, Service, and ServiceAccount resource types. For more information, see https://aka.ms/kubepolicydoc."
  management_group_name = data.azurerm_management_group.mg-root.name

  metadata = <<METADATA
    {
      "version": "2.1.2",
      "category": "Kubernetes"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "field": "type",
        "in": [
          "AKS Engine",
          "Microsoft.Kubernetes/connectedClusters",
          "Microsoft.ContainerService/managedClusters"
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "constraintTemplate": "https://store.policy.core.windows.net/kubernetes/block-default-namespace/v1/template.yaml",
          "constraint": "https://store.policy.core.windows.net/kubernetes/block-default-namespace/v1/constraint.yaml",
          "excludedNamespaces": "[parameters('excludedNamespaces')]",
          "namespaces": "[parameters('namespaces')]",
          "labelSelector": "[parameters('labelSelector')]"
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
          "description": "'audit' allows a non-compliant resource to be created or updated, but flags it as non-compliant. 'deny' blocks the non-compliant resource creation or update. 'disabled' turns off the policy."
        },
        "allowedValues": [
          "audit",
          "deny",
          "disabled"
        ],
        "defaultValue": "audit"
      },
      "excludedNamespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace exclusions",
          "description": "List of Kubernetes namespaces to exclude from policy evaluation. System namespaces \"kube-system\", \"gatekeeper-system\" and \"azure-arc\" are always excluded by design."
        },
        "defaultValue": [
          "kube-system",
          "gatekeeper-system",
          "azure-arc"
        ]
      },
      "namespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace inclusions",
          "description": "List of Kubernetes namespaces to only include in policy evaluation. An empty list means the policy is applied to all resources in all namespaces."
        },
        "defaultValue": [
          "default"
        ]
      },
      "labelSelector": {
        "type": "object",
        "metadata": {
          "displayName": "Kubernetes label selector",
          "description": "Label query to select Kubernetes resources for policy evaluation. An empty label selector matches all Kubernetes resources."
        },
        "defaultValue": {},
        "schema": {
          "description": "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all resources.",
          "type": "object",
          "properties": {
            "matchLabels": {
              "description": "matchLabels is a map of {key,value} pairs.",
              "type": "object",
              "additionalProperties": {
                "type": "string"
              },
              "minProperties": 1
            },
            "matchExpressions": {
              "description": "matchExpressions is a list of values, a key, and an operator.",
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "key": {
                    "description": "key is the label key that the selector applies to.",
                    "type": "string"
                  },
                  "operator": {
                    "description": "operator represents a key's relationship to a set of values.",
                    "type": "string",
                    "enum": [
                      "In",
                      "NotIn",
                      "Exists",
                      "DoesNotExist"
                    ]
                  },
                  "values": {
                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty.",
                    "type": "array",
                    "items": {
                      "type": "string"
                    }
                  }
                },
                "required": [
                  "key",
                  "operator"
                ],
                "additionalProperties": false
              },
              "minItems": 1
            }
          },
          "additionalProperties": false
        }
      }
    }
  PARAMETERS
}

# -------- Azure Policy - Kubernetes cluster containers should only listen on allowed ports ----------

resource "azurerm_policy_definition" "azpoldef-ContainerAllowedPorts" {
  name                  = "azpoldef-ContainerAllowedPorts"
  display_name          = "azpoldef-ContainerAllowedPorts"
  policy_type           = "Custom"
  mode                  = "Microsoft.Kubernetes.Data"
  description           = "Restrict containers to listen only on allowed ports to secure access to the Kubernetes cluster. The policy is deprecating since container port is only informative field which cannot decide the port container is actually using. For more information, see https://aka.ms/kubepolicydoc."
  management_group_name = data.azurerm_management_group.mg-root.name

  metadata = <<METADATA
    {
      "version": "6.1.2",
      "category": "Kubernetes"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "field": "type",
        "in": [
          "AKS Engine",
          "Microsoft.Kubernetes/connectedClusters",
          "Microsoft.ContainerService/managedClusters"
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "constraintTemplate": "https://store.policy.core.windows.net/kubernetes/container-allowed-ports/v1/template.yaml",
          "constraint": "https://store.policy.core.windows.net/kubernetes/container-allowed-ports/v1/constraint.yaml",
          "excludedNamespaces": "[parameters('excludedNamespaces')]",
          "namespaces": "[parameters('namespaces')]",
          "labelSelector": "[parameters('labelSelector')]",
          "values": {
            "allowedContainerPorts": "[parameters('allowedContainerPortsList')]",
            "allowedPorts": "[parameters('allowedContainerPortsList')]"
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
          "description": "'Audit' allows a non-compliant resource to be created, but flags it as non-compliant. 'Deny' blocks the resource creation. 'Disable' turns off the policy."
        },
        "allowedValues": [
          "audit",
          "deny",
          "disabled"
        ],
        "defaultValue": "deny"
      },
      "excludedNamespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace exclusions",
          "description": "List of Kubernetes namespaces to exclude from policy evaluation. System namespaces \"kube-system\", \"gatekeeper-system\" and \"azure-arc\" are always excluded by design."
        },
        "defaultValue": [
          "kube-system",
          "gatekeeper-system",
          "azure-arc"
        ]
      },
      "namespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace inclusions",
          "description": "List of Kubernetes namespaces to only include in policy evaluation. An empty list means the policy is applied to all resources in all namespaces."
        },
        "defaultValue": []
      },
      "labelSelector": {
        "type": "Object",
        "metadata": {
          "displayName": "Kubernetes label selector",
          "description": "Label query to select Kubernetes resources for policy evaluation. An empty label selector matches all Kubernetes resources."
        },
        "defaultValue": {},
        "schema": {
          "description": "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all resources.",
          "type": "object",
          "properties": {
            "matchLabels": {
              "description": "matchLabels is a map of {key,value} pairs.",
              "type": "object",
              "additionalProperties": {
                "type": "string"
              },
              "minProperties": 1
            },
            "matchExpressions": {
              "description": "matchExpressions is a list of values, a key, and an operator.",
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "key": {
                    "description": "key is the label key that the selector applies to.",
                    "type": "string"
                  },
                  "operator": {
                    "description": "operator represents a key's relationship to a set of values.",
                    "type": "string",
                    "enum": [
                      "In",
                      "NotIn",
                      "Exists",
                      "DoesNotExist"
                    ]
                  },
                  "values": {
                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty.",
                    "type": "array",
                    "items": {
                      "type": "string"
                    }
                  }
                },
                "required": [
                  "key",
                  "operator"
                ],
                "additionalProperties": false
              },
              "minItems": 1
            }
          },
          "additionalProperties": false
        }
      },
      "allowedContainerPortsList": {
        "type": "Array",
        "metadata": {
          "displayName": "Allowed container ports list",
          "description": "The list of container ports allowed in a Kubernetes cluster. Array only accepts strings. Example: [\"443\", \"80\"]"
        }
      }
    }
  PARAMETERS
}

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

# -------- Azure Policy - Kubernetes clusters should use internal load balancers ----------

resource "azurerm_policy_definition" "azpoldef-LoadBalancerNoPublicIps" {
  name                  = "azpoldef-LoadBalancerNoPublicIps"
  display_name          = "azpoldef-LoadBalancerNoPublicIps"
  policy_type           = "Custom"
  mode                  = "Microsoft.Kubernetes.Data"
  description           = "Use internal load balancers to make a Kubernetes service accessible only to applications running in the same virtual network as the Kubernetes cluster. For more information, see https://aka.ms/kubepolicydoc."
  management_group_name = data.azurerm_management_group.mg-root.name

  metadata = <<METADATA
    {
      "version": "6.0.1",
      "category": "Kubernetes"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "field": "type",
        "in": [
          "AKS Engine",
          "Microsoft.ContainerService/managedClusters"
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "constraintTemplate": "https://store.policy.core.windows.net/kubernetes/load-balancer-no-public-ips/v1/template.yaml",
          "constraint": "https://store.policy.core.windows.net/kubernetes/load-balancer-no-public-ips/v1/constraint.yaml",
          "excludedNamespaces": "[parameters('excludedNamespaces')]",
          "namespaces": "[parameters('namespaces')]",
          "labelSelector": "[parameters('labelSelector')]"
        }
      }
    }
  POLICY_RULE

  parameters = <<PARAMETERS
    {
      "effect": {
        "type": "String",
        "defaultValue": "deny",
        "allowedValues": [
          "audit",
          "deny",
          "disabled"
        ],
        "metadata": {
          "displayName": "Effect",
          "description": "'Audit' allows a non-compliant resource to be created, but flags it as non-compliant. 'Deny' blocks the resource creation. 'Disable' turns off the policy."
        }
      },
      "excludedNamespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace exclusions",
          "description": "List of Kubernetes namespaces to exclude from policy evaluation. System namespaces \"kube-system\", \"gatekeeper-system\" and \"azure-arc\" are always excluded by design."
        },
        "defaultValue": ["kube-system", "gatekeeper-system", "azure-arc"]
      },
      "namespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace inclusions",
          "description": "List of Kubernetes namespaces to only include in policy evaluation. An empty list means the policy is applied to all resources in all namespaces."
        },
        "defaultValue": []
      },
      "labelSelector": {
        "type": "object",
        "metadata": {
          "displayName": "Kubernetes label selector",
          "description": "Label query to select Kubernetes resources for policy evaluation. An empty label selector matches all Kubernetes resources."
        },
        "defaultValue": {},
        "schema": {
          "description": "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all resources.",
          "type": "object",
          "properties": {
            "matchLabels": {
              "description": "matchLabels is a map of {key,value} pairs.",
              "type": "object",
              "additionalProperties": {
                "type": "string"
              },
              "minProperties": 1
            },
            "matchExpressions": {
              "description": "matchExpressions is a list of values, a key, and an operator.",
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "key": {
                    "description": "key is the label key that the selector applies to.",
                    "type": "string"
                  },
                  "operator": {
                    "description": "operator represents a key's relationship to a set of values.",
                    "type": "string",
                    "enum": [
                      "In",
                      "NotIn",
                      "Exists",
                      "DoesNotExist"
                    ]
                  },
                  "values": {
                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty.",
                    "type": "array",
                    "items": {
                      "type": "string"
                    }
                  }
                },
                "required": [
                  "key",
                  "operator"
                ],
                "additionalProperties": false
              },
              "minItems": 1
            }
          },
          "additionalProperties": false
        }
      }
    }
  PARAMETERS
}

