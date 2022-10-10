module "vm_spoke_01" {
  source = "./modules/vm"
  providers = {
    azurerm.virtual-machine = azurerm.spoke
  }
  admin_password       = "paASDDAssw0rd123!@#"
  admin_username       = "adminuser"
  location             = data.azurerm_resource_group.spoke_rg.location
  resource_group_name  = data.azurerm_resource_group.spoke_rg.name
  subnet_id            = module.vnet_spoke_01.subnets["vm"].id
  use_public_ip        = true
  virtual_machine_name = "vm-spoke-01"
}

module "vm_spoke_02" {
  source = "./modules/vm"
  providers = {
    azurerm.virtual-machine = azurerm.spoke
  }
  admin_password       = "paASDDAssw0rd123!@#"
  admin_username       = "adminuser"
  location             = data.azurerm_resource_group.spoke_rg.location
  resource_group_name  = data.azurerm_resource_group.spoke_rg.name
  subnet_id            = module.vnet_spoke_02.subnets["vm"].id
  use_public_ip        = true
  virtual_machine_name = "vm-spoke-02"
}
