data "azurerm_resource_group" "dev-prolab" {
  name = "dev-prolab0-rg"
}

data "azurerm_resource_group" "dev-net-rg" {
  name = "dev-net-rg"
}

data "azurerm_resource_group" "dev-dns-rg" {
  name = "dev-dns-rg"
}

data "azurerm_private_dns_zone" "akszone" {
  name                = "akszone.privatelink.westeurope.azmk8s.io"
  resource_group_name = data.azurerm_resource_group.dev-dns-rg.name
}

data "azurerm_virtual_network" "vnet-dev-10-100-0-0--16" {
  name = "vnet-dev-10-100-0-0--16"
  resource_group_name = data.azurerm_resource_group.dev-net-rg.name
}

data "azurerm_subnet" "subnet-frontend" {
  name                 = "subnet-frontend-0-10-100-0-0--24"
  virtual_network_name = data.azurerm_virtual_network.vnet-dev-10-100-0-0--16.name
  resource_group_name  = data.azurerm_resource_group.dev-net-rg.name
}

data "azurerm_log_analytics_workspace" "loganal01" {
  name                = "loganal01"
  resource_group_name = data.azurerm_resource_group.dev-prolab.name
}

data "azurerm_user_assigned_identity" "aks-dev-01-ui" {
  name = "aks-dev-01-ui"
  resource_group_name = data.azurerm_resource_group.dev-prolab.name
}



resource "azurerm_kubernetes_cluster" "aks-dev-01" {
  name                = "aks-dev-01"
  location            = data.azurerm_resource_group.dev-prolab.location
  resource_group_name = data.azurerm_resource_group.dev-prolab.name
  
  #dns_prefix          = "aks-dev-01"

  dns_prefix_private_cluster = "aks-dev-01"
  
  #private_dns_zone_id = "None"

  #private_cluster_public_fqdn_enabled = true
  
  private_dns_zone_id = data.azurerm_private_dns_zone.akszone.id
  
  #api_server_authorized_ip_ranges = ""
  
  node_resource_group     = "rg-aks-nodes"
    
  private_cluster_enabled = true

  #Pewnie wersja Paid
  
  sku_tier = "Free"

  #set the disc encryption id of disk set
  #disk_encryption_set_id = azurerm_disk_encryption_set.example.id

  network_profile {
    network_plugin     = "kubenet"
    pod_cidr           = "10.200.0.0/16"
    service_cidr       = "10.254.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.254.100.0"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      managed            = true
      azure_rbac_enabled = false
    }
  }

  default_node_pool {
    name           = "default"
    vnet_subnet_id = data.azurerm_subnet.subnet-frontend.id
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
  }

   identity {
     type                      = "UserAssigned"
     user_assigned_identity_id = data.azurerm_user_assigned_identity.aks-dev-01-ui.id
   }

   addon_profile {

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loganal01.id
    }

    kube_dashboard {
      enabled = false
    }

  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks-dev-01.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks-dev-01.kube_config_raw
  sensitive = true
}

# resource "azurerm_kubernetes_cluster_node_pool" "aks-dev-01-np" {
#   name                  = "anotherpool"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-dev-01.id
#   vm_size               = "Standard_DS2_v2"
#   node_count            = 1

#   tags = {
#     Environment = "Production"
#   }
# }







# oms_agent block supports the following:

# enabled - (Required) Is the OMS Agent Enabled?

# log_analytics_workspace_id - (Optional) The ID of the Log Analytics Workspace which the OMS Agent should send data to. Must be present if enabled is true.