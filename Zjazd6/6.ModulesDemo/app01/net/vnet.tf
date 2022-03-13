

module "vnet-dev-01" {

  source = "../../MODULES/virtual-network"

  vnet_object = {
    name          = "vnet-dev-01"
    rg_name       = data.azurerm_resource_group.module01-rg.name
    address_space = ["10.0.0.0/16", "10.1.0.0/16"]
    dns_servers   = ["10.0.0.1", "10.1.0.1"]
  }

  depends_on = [
     data.azurerm_resource_group.module01-rg
  ]
}

module "vnet-hub-01" {

  source = "../../MODULES/virtual-network"

  vnet_object = {
    name          = "vnet-hub-01"
    rg_name       = data.azurerm_resource_group.module01-rg.name
    address_space = ["10.100.0.0/16"]
    dns_servers   = ["10.0.0.1", "10.1.0.1"]
  }

  depends_on = [
     data.azurerm_resource_group.module01-rg
  ]
}

module "vnet-hub-01-subnet-01" {

  source = "../../MODULES/subnet"

  subnet_object = {
    name                                   = "subnet-01"
    rg_name                                = data.azurerm_resource_group.module01-rg.name
    vnet_name                              = module.vnet-dev-01.name
    address_space                          = ["10.0.0.0/24"]
    private_link_endpoint_network_policies = false
    private_link_service_network_policies  = false
    service_endpoints                      = []
    service_endpoint_policy_ids            = []
    route_table_id                         = "" #module.vnet-hub-01-subnet-01-route-table.id
    nsg_id                                 = "" #module.vnet-hub-01-subnet-01-nsg.id
  }

  depends_on = [
    module.vnet-hub-01,
    module.vnet-hub-01-subnet-01-nsg
  ]
}

module "vnet-hub-01-subnet-01-nsg" {

  source = "../../MODULES/nsg"

  nsg_object = {
    name    = "vnet-hub-01-subnet-01-nsg"
    rg_name = data.azurerm_resource_group.module01-rg.name
  }

  depends_on = [
     data.azurerm_resource_group.module01-rg
  ]
}

module "vnet-hub-01-subnet-01-nsg-security-rule" {

  source = "../../MODULES/nsg-security-rule"
  nsg_rule_object = {
    nsg_name                                   = module.vnet-hub-01-subnet-01-nsg.name
    rg_name                                    = data.azurerm_resource_group.module01-rg.name
    name                                       = "nsg-sec-rule01"
    description                                = "nsg-sec-rule01"
    direction                                  = "Inbound"
    priority                                   = "100"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_address_prefix                      = "*"
    source_port_range                          = "*"
    destination_address_prefix                 = "*"
    destination_port_range                     = "*"
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }

  depends_on = [
     data.azurerm_resource_group.module01-rg
  ]

}

module "vnet-hub-01-subnet-01-route-table" {

  source = "../../MODULES/route-table"
  route_table_object = {
    name                          = "vnet-hub-01-subnet-01-route-table"
    rg_name                       = data.azurerm_resource_group.module01-rg.name
    disable_bgp_route_propagation = false
  }

  depends_on = [
    data.azurerm_resource_group.module01-rg
  ]
}