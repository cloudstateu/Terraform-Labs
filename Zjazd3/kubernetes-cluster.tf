resource "azurerm_kubernetes_cluster" "aks-mf-clusterdev01" {
  name                = "aks-mf-clusterdev01"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  dns_prefix          = "aks-mf-clusterdev01"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2ms"
  }

  node_resource_group = format("%s-%s",var.aks-cluster-name, local.studentPrefix)

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}