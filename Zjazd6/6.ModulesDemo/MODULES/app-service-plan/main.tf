data "azurerm_subnet" "ab_ase_subnet" {
    name                 = var.app_service_object.subnet_name
    virtual_network_name = var.app_service_object.vnet_name
    resource_group_name  = var.app_service_object.vnet_rg_name
}

resource "azurerm_app_service_environment" "app_service_environment" {
    name                         = var.app_service_object.ase_name
    resource_group_name          = var.app_service_object.ase_rg_name

    subnet_id                    = data.azurerm_subnet.ab_ase_subnet.id
    pricing_tier                 = var.app_service_object.ase_tier

    front_end_scale_factor       = var.app_service_object.ase_front_scale_factor
    
    internal_load_balancing_mode = var.app_service_object.ase_vnet_endpoints
    allowed_user_ip_cidrs        = var.app_service_object.ase_egress_ips
        
    cluster_setting {
        name  = "DisableTls1.0"
        value = "1"
    }

    cluster_setting {
        name  = "InternalEncryption"
        value = "true"
    }

    cluster_setting {
        name  = "FrontEndSSLCipherSuiteOrder"
        value = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
    }

   
    lifecycle {
      ignore_changes = [
          tags
      ]
    }
        
}

data "azurerm_resource_group" "asp_resource_group" {
    resource_group_name = var.asp_object.rg_name
}

resource "azurerm_app_service_plan" "ab_app_service_plan" {

    name                = "api-appserviceplan-pro"
    location            = data.azurerm_resource_group.asp_resource_group.location
    resource_group_name = var.asp_object.rg_name
    kind                = var.asp_object.os_name
    
    sku {
    tier = "PremiumContainer"
    size = "PC2"
    }
    
    lifecycle {
      ignore_changes = [
          tags
      ]
    }
}