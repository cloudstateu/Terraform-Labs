resource "azurerm_resource_group" "rg-spoke" {
  provider = azurerm.spoke
  name     = "rg-app-${var.app_name}"
  location = var.location

  tags = merge(var.resource_tags, { CreatedDate = timestamp() })

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}
