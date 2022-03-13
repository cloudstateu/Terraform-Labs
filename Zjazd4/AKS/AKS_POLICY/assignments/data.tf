data "azurerm_management_group" "mg-root" {
  name = "root-managment-group"
}

data "azurerm_policy_definition" "azpoldef-AKSAADAdminGroup" {
  name = "azpoldef-AKSAADAdminGroup"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-CMK" {
  name = "azpoldef-CMK"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-AKSDefenderSecurityProfileAudit" {
  name = "azpoldef-AKSDefenderSecurityProfileAudit"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-AKSDefenderSecurityProfileDeploy" {
  name = "azpoldef-AKSDefenderSecurityProfileDeploy"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-DisableLocalAccounts" {
  name = "azpoldef-DisableLocalAccounts"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-AKSEncryptionAtHost" {
  name = "azpoldef-AKSEncryptionAtHost"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-AKSPrivateCluster" {
  name = "azpoldef-AKSPrivateCluster"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-BlockDefaultNamespace" {
  name = "azpoldef-BlockDefaultNamespace"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-ContainerAllowedPorts" {
  name = "azpoldef-ContainerAllowedPorts"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-DataConnectorsAzureKubernetes" {
  name = "azpoldef-DataConnectorsAzureKubernetes"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-KubernetesAuditDiagnosticLog" {
  name = "azpoldef-KubernetesAuditDiagnosticLog"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-LoadBalancerNoPublicIps" {
  name = "azpoldef-LoadBalancerNoPublicIps"
  management_group_name = data.azurerm_management_group.mg-root.name
}

data "azurerm_policy_definition" "azpoldef-AllowedExternalIPs" {
  name = "azpoldef-AllowedExternalIPs"
  management_group_name = data.azurerm_management_group.mg-root.name
}
