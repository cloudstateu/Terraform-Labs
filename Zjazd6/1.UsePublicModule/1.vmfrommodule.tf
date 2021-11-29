resource "azurerm_resource_group" "simplevm-rg" {
  name     = "simplevm-rg"
  location = "westeurope"
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.simplevm-rg.name
  address_spaces      = ["10.0.0.0/16", "10.2.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.simplevm-rg]
}

module "compute" {
  source  = "Azure/compute/azurerm"
  version = "3.14.0"
  # insert the 3 required variablemodule "linuxservers" {
  resource_group_name = azurerm_resource_group.simplevm-rg.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["linsimplevmips"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]

  depends_on = [azurerm_resource_group.simplevm-rg]
}