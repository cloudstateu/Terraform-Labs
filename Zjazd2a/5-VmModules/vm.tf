module "vm01" {
  source = "./modules/vm"
  providers = {
    azurerm.virtual-machine = azurerm
  }
  admin_password = "ppssWRD123!@#"
  admin_username = "azureuser"
  location = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  subnet_id = module.network.vnet_subnets[0]
  use_public_ip = false
  virtual_machine_name = "vm01"
}

module "vm02" {
  source = "./modules/vm"
  providers = {
    azurerm.virtual-machine = azurerm
  }
  admin_password = "ppssWRD123!@#"
  admin_username = "azureuser"
  location = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  subnet_id = module.network.vnet_subnets[1]
  use_public_ip = true
  virtual_machine_name = "vm02"
}
