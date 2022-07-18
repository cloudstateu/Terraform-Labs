module "network" {
  source              = "registry.terraform.io/Azure/network/azurerm"
  resource_group_name = data.azurerm_resource_group.rg.name
  address_spaces      = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]
}
