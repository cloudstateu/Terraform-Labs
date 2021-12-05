resource "azurerm_virtual_machine_extension" "mmaagent" {
  name                 = "mmaagent"
  virtual_machine_id   = azurerm_linux_virtual_machine.VM-WFE01-DEV.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "OmsAgentForLinux"
  type_handler_version = "1.13"
  auto_upgrade_minor_version = "true"
  settings = <<SETTINGS
    {
      "workspaceId": "${azurerm_log_analytics_workspace.loganal01.workspace_id}"
    }
SETTINGS
   protected_settings = <<PROTECTED_SETTINGS
   {
      "workspaceKey": "${azurerm_log_analytics_workspace.loganal01.primary_shared_key}"
   }
PROTECTED_SETTINGS
}