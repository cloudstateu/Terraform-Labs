module "linuxservers" {
  source              = "registry.terraform.io/Azure/compute/azurerm"
  resource_group_name = data.azurerm_resource_group.rg.name
  vm_os_simple        = "UbuntuServer"
  vnet_subnet_id      = module.network.vnet_subnets[0]
  vm_size             = "Standard_D2as_v5"

  admin_password = "testowe123!@#"
  enable_ssh_key = false
}
