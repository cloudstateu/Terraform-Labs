# RG - RG-VNETS-DEV
module "rg-vnets-test" {
  source = "./modules/rg"

  resource_group_object = var.resource_group_object_testrg

  resource_group_tags = var.resource_group_tags_testrg
}

# RG - RG-VNETS-DEV
module "rg-vnets-dev" {
  source = "./modules/rg"

  resource_group_object = var.resource_group_object_devrg

  resource_group_tags = var.resource_group_tags_devrg
}

output "rg-vnet-test-location" {
  description = "RG VNET TEST LOCATION"
  value       = module.rg-vnets-test.location
}


output "rg-vnet-dev-location" {
  description = "RG VNET DEV LOCATION"
  value       = module.rg-vnets-dev.location
}