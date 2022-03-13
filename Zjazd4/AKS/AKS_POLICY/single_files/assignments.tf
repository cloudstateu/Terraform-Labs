
#TODO
resource "azurerm_management_group_policy_assignment" "pa-AKSAADAdminGroup" {
  name                 = "pa-AKSAADAdminGroup"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-AKSAADAdminGroup.id
  description          = "Assign azpoldef-AKSAADAdminGroup policy to mg-root management group"
  display_name         = "pa-AKSAADAdminGroup"
  enforce              = "false"

  identity {
    type = "SystemAssigned"
  }

  location = "West Europe"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  #TODO - Add admin group object ids
  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "DeployIfNotExists"
      },
      "adminGroupObjectIDs": {
        "value": [
          "b1c87ffa-963c-46b4-b764-5d518f864790"
        ]
      }
    }
  PARAMETERS
}


# TODO
resource "azurerm_management_group_policy_assignment" "pa-CMK" {
  name                 = "pa-CMK"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-CMK.id
  description          = "Assign azpoldef-CMK policy to mg-root management group"
  display_name         = "pa-CMK"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "Deny"
      }
    }
  PARAMETERS
}

resource "azurerm_management_group_policy_assignment" "pa-AKSDefenderSecurityProfileAudit" {
  name                 = "pa-AKSDefenderSecAudit"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-AKSDefenderSecurityProfileAudit.id
  description          = "Assign azpoldef-AKSDefenderSecurityProfileAudit policy to mg-root management group"
  display_name         = "pa-AKSDefenderSecAudit"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "1.0.1",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "Audit"
      }
    }
  PARAMETERS
}

#TODO
resource "azurerm_management_group_policy_assignment" "pa-AKSDefenderSecurityProfileDeploy" {
  name                 = "pa-AKSDefenderSecDeploy"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-AKSDefenderSecurityProfileDeploy.id
  description          = "Assign azpoldef-AKSDefenderSecurityProfileDeploy policy to mg-root management group"
  display_name         = "pa-AKSDefenderSecDeploy"
  enforce              = "false"

  identity {
    type = "SystemAssigned"
  }
  
  location = "West Europe"


  metadata = <<METADATA
    {
      "version": "1.0.1",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "DeployIfNotExists"
      }
    }
  PARAMETERS
}

# TODO
resource "azurerm_management_group_policy_assignment" "pa-DisableLocalAccounts" {
  name                 = "pa-DisableLocalAccounts"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-DisableLocalAccounts.id
  description          = "Assign azpoldef-DisableLocalAccounts policy to mg-root management group"
  display_name         = "pa-DisableLocalAccounts"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "Deny"
      }
    }
  PARAMETERS
}

resource "azurerm_management_group_policy_assignment" "pa-AKSEncryptionAtHost" {
  name                 = "pa-AKSEncryptionAtHost"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-AKSEncryptionAtHost.id
  description          = "Assign azpoldef-AKSEncryptionAtHost policy to mg-root management group"
  display_name         = "pa-AKSEncryptionAtHost"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "Deny"
      }
    }
  PARAMETERS
}

resource "azurerm_management_group_policy_assignment" "pa-AKSPrivateCluster" {
  name                 = "pa-AKSPrivateCluster"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-AKSPrivateCluster.id
  description          = "Assign azpoldef-AKSPrivateCluster policy to mg-root management group"
  display_name         = "pa-AKSPrivateCluster"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "Deny"
      }
    }
  PARAMETERS
}

resource "azurerm_management_group_policy_assignment" "pa-BlockDefaultNamespace" {
  name                 = "pa-BlockDefaultNamespace"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-BlockDefaultNamespace.id
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

# TODO
resource "azurerm_management_group_policy_assignment" "pa-ContainerAllowedPorts" {
  name                 = "pa-ContainerAllowedPorts"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-ContainerAllowedPorts.id
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
        "value" : ["8080","8888","443","53"]
      }
    }
  PARAMETERS
}


resource "azurerm_management_group_policy_assignment" "pa-DataConnectorsAzureKubernetes" {
  name                 = "pa-DataConnectorsAKS"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-DataConnectorsAzureKubernetes.id
  description          = "Assign azpoldef-DataConnectorsAzureKubernetes policy to mg-root management group"
  display_name         = "pa-DataConnectorsAKS"
  enforce              = "false"

  identity {
    type = "SystemAssigned"
  }
  location = "West Europe"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "DeployIfNotExists"
      },
      "diagnosticsSettingNameToUse": {
        "value": "AzureKubernetesDiagnosticsLogsToWorkspace"
      },
      "logAnalytics": {
        "value": "loganal01"
      },
      "AllMetrics": {
        "value": "True"
      },
      "kube-apiserver": {
        "value": "True"
      },
      "kube-audit": {
        "value": "True"
      },
      "kube-controller-manager": {
        "value": "True"
      },
      "kube-scheduler": {
        "value": "True"
      },
      "cluster-autoscaler": {
        "value": "True"
      },
      "kube-audit-admin": {
        "value": "True"
      },
      "guard": {
        "value": "True"
      }
    }
  PARAMETERS
}

resource "azurerm_management_group_policy_assignment" "pa-KubernetesAuditDiagnosticLog" {
  name                 = "pa-K8sAuditDiagnosticLog"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-KubernetesAuditDiagnosticLog.id
  description          = "Assign azpoldef-KubernetesAuditDiagnosticLog policy to mg-root management group"
  display_name         = "pa-K8sAuditDiagnosticLog"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Kubernetes"
    }
  METADATA

  parameters = <<PARAMETERS
    {
      "effect": {
        "value": "AuditIfNotExists"
      },
      "requiredRetentionDays": {
        "value": "365"
      }
    }
  PARAMETERS
}

# TODO
resource "azurerm_management_group_policy_assignment" "pa-LoadBalancerNoPublicIps" {
  name                 = "pa-LBNoPublicIps"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-LoadBalancerNoPublicIps.id
  description          = "Assign azpoldef-LoadBalancerNoPublicIps policy to mg-root management group"
  display_name         = "pa-LBNoPublicIps"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "6.0.1",
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
      }
    }
  PARAMETERS
}

resource "azurerm_management_group_policy_assignment" "pa-AllowedExternalIPs" {
  name                 = "pa-AllowedExternalIPs"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = azurerm_policy_definition.azpoldef-AllowedExternalIPs.id
  description          = "Assign azpoldef-AllowedExternalIPs policy to mg-root management group"
  display_name         = "pa-AllowedExternalIPs"
  enforce              = "false"

  metadata = <<METADATA
    {
      "version": "1.0.0",
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
      },
      "allowedExternalIPs": {
        "value": [
        ]
      }
    }
  PARAMETERS
}