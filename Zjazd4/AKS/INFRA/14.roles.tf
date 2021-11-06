resource "azuread_application" "aksclusterinstallspn" {
  display_name = "aksclusterinstallspn"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "aksclusterinstallspn" {
  application_id               = azuread_application.aksclusterinstallspn.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azurerm_role_assignment" "aksclusterinstallspn-role-aks-cluster-install" {
  depends_on = [
    azurerm_role_definition.aks-cluster-install
  ]
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = azurerm_role_definition.aks-cluster-install.name
  principal_id         = azuread_service_principal.aksclusterinstallspn.object_id
}



resource "azurerm_role_definition" "aks-cluster-install" {
  name  = "aks-cluster-install"
  scope = "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  #data.azurerm_resource_group.tests.id
  description = "aks-cluster-install"

  permissions {
    actions = [
      "Microsoft.Compute/diskEncryptionSets/read",
      "Microsoft.Compute/proximityPlacementGroups/write",
      "Microsoft.Network/applicationGateways/read",
      "Microsoft.Network/applicationGateways/write",
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/publicIPAddresses/join/action",
      "Microsoft.Network/publicIPPrefixes/join/action",
      "Microsoft.OperationalInsights/workspaces/sharedkeys/read",
      "Microsoft.OperationalInsights/workspaces/read",
      "Microsoft.OperationsManagement/solutions/write",
      "Microsoft.OperationsManagement/solutions/read",
      "Microsoft.ManagedIdentity/userAssignedIdentities/assign/action",
      "Microsoft.ContainerService/managedClusters/write",
      "Microsoft.ContainerService/managedClusters/delete",
      "Microsoft.ContainerService/managedClusters/agentPools/write",
      "Microsoft.ContainerService/managedClusters/agentPools/delete",
      "Microsoft.ContainerService/managedClusters/listClusterAdminCredential/action"
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  ]
}

resource "azurerm_role_definition" "aks-cluster-manager_network" {
  name  = "aks-cluster-manager_network"
  scope = "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  #data.azurerm_resource_group.tests.id
  description = "aks-cluster-manager_network"

  permissions {
    actions = [
      "Microsoft.Network/loadBalancers/delete",
      "Microsoft.Network/loadBalancers/read",
      "Microsoft.Network/loadBalancers/write",
      #"Microsoft.Network/publicIPAddresses/delete",
      #"Microsoft.Network/publicIPAddresses/read",
      #"Microsoft.Network/publicIPAddresses/write",
      #"Microsoft.Network/publicIPAddresses/join/action",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/networkSecurityGroups/write",
      #"Microsoft.Compute/disks/delete",
      #"Microsoft.Compute/disks/read",
      #"Microsoft.Compute/disks/write",
      #"Microsoft.Compute/locations/DiskOperations/read",
      #TODO: do czego uzywamych tych rol
      #"Microsoft.Storage/storageAccounts/delete",
      #"Microsoft.Storage/storageAccounts/listKeys/action",
      #"Microsoft.Storage/storageAccounts/read",
      #"Microsoft.Storage/storageAccounts/write",
      #"Microsoft.Storage/operations/read",
      #TODO: do czego uzywamych tych rol
      "Microsoft.Network/routeTables/read",
      "Microsoft.Network/routeTables/routes/delete",
      "Microsoft.Network/routeTables/routes/read",
      "Microsoft.Network/routeTables/routes/write",
      "Microsoft.Network/routeTables/write",
      #"Microsoft.Compute/virtualMachines/read",
      #"Microsoft.Compute/virtualMachines/write",
      #"Microsoft.Compute/virtualMachineScaleSets/read",
      #"Microsoft.Compute/virtualMachineScaleSets/virtualMachines/read",
      #"Microsoft.Compute/virtualMachineScaleSets/virtualmachines/instanceView/read",
      #"Microsoft.Network/networkInterfaces/write",
      #"Microsoft.Compute/virtualMachineScaleSets/write",
      #"Microsoft.Compute/virtualMachineScaleSets/virtualmachines/write",
      "Microsoft.Network/networkInterfaces/read",
      #"Microsoft.Compute/virtualMachineScaleSets/virtualMachines/networkInterfaces/read",
      #TODO: testy
      #"Microsoft.Compute/virtualMachineScaleSets/virtualMachines/networkInterfaces/ipconfigurations/publicipaddresses/read",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/subnets/read",
      #"Microsoft.Compute/snapshots/delete",
      #"Microsoft.Compute/snapshots/read",
      #"Microsoft.Compute/snapshots/write",
      #"Microsoft.Compute/locations/vmSizes/read",
      #"Microsoft.Compute/locations/operations/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  ]
}

resource "azurerm_role_definition" "aks-cluster-manager_vm" {
  name  = "aks-cluster-manager_vm"
  scope = "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  #data.azurerm_resource_group.tests.id
  description = "aks-cluster-manager_vm"

  permissions {
    actions = [
      "Microsoft.ContainerService/managedClusters/*",
      #"Microsoft.Network/loadBalancers/delete",
      #"Microsoft.Network/loadBalancers/read",
      #"Microsoft.Network/loadBalancers/write",
      #"Microsoft.Network/publicIPAddresses/delete",
      #"Microsoft.Network/publicIPAddresses/read",
      #"Microsoft.Network/publicIPAddresses/write",
      #"Microsoft.Network/publicIPAddresses/join/action",
      #"Microsoft.Network/networkSecurityGroups/read",
      #"Microsoft.Network/networkSecurityGroups/write",
      "Microsoft.Compute/disks/delete",
      "Microsoft.Compute/disks/read",
      "Microsoft.Compute/disks/write",
      "Microsoft.Compute/locations/DiskOperations/read",
      #TODO: do czego uzywamych tych rol
      #"Microsoft.Storage/storageAccounts/delete",
      #"Microsoft.Storage/storageAccounts/listKeys/action",
      #"Microsoft.Storage/storageAccounts/read",
      #"Microsoft.Storage/storageAccounts/write",
      #"Microsoft.Storage/operations/read",
      #TODO: do czego uzywamych tych rol
      #"Microsoft.Network/routeTables/read",
      #"Microsoft.Network/routeTables/routes/delete",
      #"Microsoft.Network/routeTables/routes/read",
      #"Microsoft.Network/routeTables/routes/write",
      #"Microsoft.Network/routeTables/write",
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.Compute/virtualMachines/write",
      "Microsoft.Compute/virtualMachineScaleSets/read",
      "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/read",
      "Microsoft.Compute/virtualMachineScaleSets/virtualmachines/instanceView/read",
      #"Microsoft.Network/networkInterfaces/write",
      "Microsoft.Compute/virtualMachineScaleSets/write",
      "Microsoft.Compute/virtualMachineScaleSets/virtualmachines/write",
      #"Microsoft.Network/networkInterfaces/read",
      "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/networkInterfaces/read",
      #TODO: testy
      "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/networkInterfaces/ipconfigurations/publicipaddresses/read",
      #"Microsoft.Network/virtualNetworks/read",
      #"Microsoft.Network/virtualNetworks/subnets/read",
      #"Microsoft.Compute/snapshots/delete",
      #"Microsoft.Compute/snapshots/read",
      #"Microsoft.Compute/snapshots/write",
      "Microsoft.Compute/locations/vmSizes/read",
      "Microsoft.Compute/locations/operations/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  ]
}

resource "azurerm_role_definition" "aks-cluster-manager_akscluster" {
  name  = "aks-cluster-manager_akscluster"
  scope = "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  #data.azurerm_resource_group.tests.id
  description = "aks-cluster-manager_akscluster"

  permissions {
    actions = [
      "Microsoft.ContainerService/managedClusters/*",
      #"Microsoft.Network/loadBalancers/delete",
      #"Microsoft.Network/loadBalancers/read",
      #"Microsoft.Network/loadBalancers/write",
      #"Microsoft.Network/publicIPAddresses/delete",
      #"Microsoft.Network/publicIPAddresses/read",
      #"Microsoft.Network/publicIPAddresses/write",
      #"Microsoft.Network/publicIPAddresses/join/action",
      # "Microsoft.Network/networkSecurityGroups/read",
      # "Microsoft.Network/networkSecurityGroups/write",
      # "Microsoft.Compute/disks/delete",
      # "Microsoft.Compute/disks/read",
      # "Microsoft.Compute/disks/write",
      # "Microsoft.Compute/locations/DiskOperations/read",
      #TODO: do czego uzywamych tych rol
      "Microsoft.Storage/storageAccounts/delete",
      "Microsoft.Storage/storageAccounts/listKeys/action",
      "Microsoft.Storage/storageAccounts/read",
      "Microsoft.Storage/storageAccounts/write",
      "Microsoft.Storage/operations/read",
      #TODO: do czego uzywamych tych rol
      "Microsoft.Network/routeTables/read",
      "Microsoft.Network/routeTables/routes/delete",
      "Microsoft.Network/routeTables/routes/read",
      "Microsoft.Network/routeTables/routes/write",
      "Microsoft.Network/routeTables/write",
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.Compute/virtualMachines/write",
      "Microsoft.Compute/virtualMachineScaleSets/read",
      "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/read",
      "Microsoft.Compute/virtualMachineScaleSets/virtualmachines/instanceView/read",
      "Microsoft.Network/networkInterfaces/write",
      "Microsoft.Compute/virtualMachineScaleSets/write",
      "Microsoft.Compute/virtualMachineScaleSets/virtualmachines/write",
      "Microsoft.Network/networkInterfaces/read",
      "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/networkInterfaces/read",
      #TODO: testy
      "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/networkInterfaces/ipconfigurations/publicipaddresses/read",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/subnets/read",
      #"Microsoft.Compute/snapshots/delete",
      #"Microsoft.Compute/snapshots/read",
      #"Microsoft.Compute/snapshots/write",
      "Microsoft.Compute/locations/vmSizes/read",
      "Microsoft.Compute/locations/operations/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  ]
}