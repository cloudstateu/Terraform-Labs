resource "azurerm_kubernetes_cluster" "aks-mf-clusterdev01" {
  name                = "aks-mf-clusterdev01"
  location            = azurerm_resource_group.k8s-dev.location
  resource_group_name = azurerm_resource_group.k8s-dev.name
  dns_prefix          = "aks-mf-clusterdev01"


  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2ms"
  }

  #drobna zmiana by na pewno znaleźć wolną grupę zasobów dla backendu klastra
  node_resource_group = format("rg-%s-%s-%s", random_string.mifurm-rand-prefix.result, var.aks-cluster-name, local.studentPrefix)

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}