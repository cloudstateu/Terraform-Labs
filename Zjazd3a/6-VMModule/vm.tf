module "vm" {
  source    = "./modules/vm"
  providers = {
    azurerm.virtual-machine = azurerm
  }
  admin_password       = "paASDDAssw0rd123!@#"
  admin_username       = "adminuser"
  location             = data.azurerm_resource_group.rg.location
  resource_group_name  = data.azurerm_resource_group.rg.name
  subnet_id            = module.network.vnet_subnets[0]
  use_public_ip        = true
  virtual_machine_name = "vm-spoke-02"
}
