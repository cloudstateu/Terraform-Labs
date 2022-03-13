module "rg-hub" {
    source = "../../MODULES/resource-group"

    providers = {
        azurerm = azurerm.provider-hub-env
        
    }

    resource_group_object = var.resource_group_object_rg_hub  //"rg-hub-mf2
    resource_group_tags   = var.resource_group_tags_rg_hub
}

module "rg-dev" {
    source = "../../MODULES/resource-group"

    providers = {
        azurerm = azurerm.provider-dev-env
    }
     

    resource_group_object = var.resource_group_object_rg_dev
    resource_group_tags   = var.resource_group_tags_rg_dev
}

module "rg-mon" {
    source = "../../MODULES/resource-group"

    providers = {
        azurerm = azurerm.provider-dev-env
    }
     

    resource_group_object = var.resource_group_object_rg_mon
    resource_group_tags   = var.resource_group_tags_rg_mon
}