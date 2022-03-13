resource "azurerm_management_group_policy_assignment" "pa-KubernetesAuditDiagnosticLog" {
  name                 = "pa-K8sAuditDiagnosticLog"
  management_group_id  = data.azurerm_management_group.mg-root.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-KubernetesAuditDiagnosticLog.id
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
