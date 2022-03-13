resource "azurerm_management_group_policy_assignment" "pa-DataConnectorsAzureKubernetes" {
  name                 = "pa-DataConnectorsAKS"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-DataConnectorsAzureKubernetes.id
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
        "value": ""
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
