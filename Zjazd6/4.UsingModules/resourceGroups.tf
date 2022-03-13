# RG - RG-VNETS-DEV
module "rg-vnets-test" {
  source = "../MODULES/resource-group"

  resource_group_object = var.resource_group_object_testrg

  resource_group_tags = var.resource_group_tags_testrg
}

# RG - RG-VNETS-DEV
module "rg-vnets-dev" {
  source = "../MODULES/resource-group"

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


# RG - RG-VNETS-DEV
module "rg-vnets-prd" {
  source = "../MODULES/resource-group"

  resource_group_object = {
     name                = "rg-vnets-prd"
     location            = "westeurope"
     lock_level          = "CanNotDelete"
   
  }

  resource_group_tags = var.resource_group_tags_testrg
}