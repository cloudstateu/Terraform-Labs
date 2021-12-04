#https://github.com/Azure/Azure-Network-Security/tree/master/Azure%20Firewall/Workbook%20-%20Azure%20Firewall%20Monitor%20Workbook

resource "azurerm_template_deployment" "empty" {
  name                = "empty"
  resource_group_name = azurerm_resource_group.armtemplaterg.name

  template_body = file("template/storage.json")

  deployment_mode = "Incremental"
}

output "message" {
  value = azurerm_template_deployment.empty.outputs["message"]
}