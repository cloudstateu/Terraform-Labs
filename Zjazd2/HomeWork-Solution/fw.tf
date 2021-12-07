##### firewall

resource "azurerm_subnet" "hub-vnet01-subnet-fw" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.hub-vnet01.name
  resource_group_name  = data.azurerm_resource_group.tf-st-rg60.name
  # firewall min subnet size /26
  address_prefixes = ["10.0.255.0/26"]
}

resource "azurerm_public_ip" "pip-fw01" {
  name                = "pip-fw01"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw01" {
  name                = "fw01"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location

  firewall_policy_id = azurerm_firewall_policy.fw01-policy.id

  ip_configuration {
    name                 = "fw01-configuration"
    subnet_id            = azurerm_subnet.hub-vnet01-subnet-fw.id
    public_ip_address_id = azurerm_public_ip.pip-fw01.id
  }
}

resource "azurerm_firewall_policy" "fw01-policy" {
  name                = "fw01-policy"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location
}

resource "azurerm_firewall_policy_rule_collection_group" "fw01-policy_rule_collection_10_0_0_0__24" {

  name               = "fw01-policy_rule_collection_10_0_0_0__24"
  firewall_policy_id = azurerm_firewall_policy.fw01-policy.id
  priority           = 1000

  network_rule_collection {
    name     = "rule_net_10_0_0_0__24"
    priority = 1000
    action   = "Allow"

    rule {
      name                  = "net_10.0.0.0_tcp_22"
      protocols             = ["TCP"]
      source_addresses      = ["10.0.0.4"]
      destination_addresses = ["10.1.0.4"]
      destination_ports     = ["22"]
    }
  }
}

output "pip-fw01-value" {
  value = azurerm_public_ip.pip-fw01.ip_address
}

