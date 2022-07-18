module "storage" {
  source = "./module/storage"
  providers = {
    azurerm = azurerm
  }

  storage_resource_group_name = data.azurerm_resource_group.rg.name
  location                    = data.azurerm_resource_group.rg.location
  storage_name                = var.storage_name
}
