module "storage1" {
  source = "./modules/storage"

  containers = {
    "app1" = {
      name = "app1"
    }
    "app2" = {
      name = "app2"
    }
  }
  location             = data.azurerm_resource_group.main_rg.location
  resource_group_name  = data.azurerm_resource_group.main_rg.name
  storage_account_name = "smstudent0a"
}

module "storage2" {
  source = "./modules/storage"

  containers = {
    "app" = {
      name = "app"
    }
  }
  location             = data.azurerm_resource_group.main_rg.location
  resource_group_name  = data.azurerm_resource_group.main_rg.name
  storage_account_name = "smstudent0b"
}
