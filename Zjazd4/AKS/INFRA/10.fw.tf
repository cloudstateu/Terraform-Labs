resource "azurerm_public_ip" "pip-fw01" {
  name                = "pip-fw01"
  location            = azurerm_resource_group.hub-net-rg.location
  resource_group_name = azurerm_resource_group.hub-net-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw01" {
  name                = "fw01"
  location            = azurerm_resource_group.hub-net-rg.location
  resource_group_name = azurerm_resource_group.hub-net-rg.name

  firewall_policy_id = azurerm_firewall_policy.fw01-policy.id

  ip_configuration {
    name                 = "fw01-configuration"
    subnet_id            = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.pip-fw01.id
  }

}

resource "azurerm_firewall_policy" "fw01-policy" {
  name                = "fw01-policy"
  location            = azurerm_resource_group.hub-net-rg.location
  resource_group_name = azurerm_resource_group.hub-net-rg.name

  dns {
    proxy_enabled = true
    servers       = ["168.63.129.16"]
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "fw01-policy_rule_collection_10_0_0_0__24" {

  name               = "fw01-policy_rule_collection_10_0_0_0__24"
  firewall_policy_id = azurerm_firewall_policy.fw01-policy.id
  priority           = 1000

  network_rule_collection {
    name     = "rule_net_aks_443"
    priority = 1000
    action   = "Allow"

    # rule {
    #   name                  = "net_aks_tcp_443"
    #   protocols             = ["TCP"]
    #   source_addresses      = [azurerm_subnet.subnet-frontend[0].address_prefix]
    #   destination_addresses = ["*"]
    #   destination_ports     = ["443"]
    # }

    # rule {
    #   name                  = "net_aks_tcp_9000"
    #   protocols             = ["TCP"]
    #   source_addresses      = [azurerm_subnet.subnet-frontend[0].address_prefix]
    #   destination_addresses = ["*"]
    #   destination_ports     = ["9000"]
    # }

    # rule {
    #   name                  = "net_aks_udp_1194"
    #   protocols             = ["UDP"]
    #   source_addresses      = [azurerm_subnet.subnet-frontend[0].address_prefix]
    #   destination_addresses = ["*"]
    #   destination_ports     = ["1194"]
    # }

    # rule {
    #   name                  = "net_aks_udp_123"
    #   protocols             = ["UDP"]
    #   source_addresses      = [azurerm_subnet.subnet-frontend[0].address_prefix]
    #   destination_addresses = ["*"]
    #   destination_ports     = ["123"]
    # }

    rule {
      name                  = "net_aks_udp_53"
      protocols             = ["UDP"]
      source_addresses      = [azurerm_subnet.subnet-frontend[0].address_prefix]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }


  }


}

output "pip-fw01-value" {
  value = azurerm_public_ip.pip-fw01.ip_address
}

# resource "azurerm_monitor_diagnostic_setting" "example" {
#   name                       = "example"
#   target_resource_id         = azurerm_firewall.fw01.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.loganal01.id

#   log {
#     category = "AzureFirewallApplicationRule"
#     enabled  = true

#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "AzureFirewallNetworkRule"
#     enabled  = true

#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "AzureFirewallDnsProxy"
#     enabled  = true

#     retention_policy {
#       enabled = false
#     }
#   }

#   metric {
#     category = "AllMetrics"

#     retention_policy {
#       enabled = false
#     }
#   }
# }


#azurerm_firewall_policy_rule_collection_group.fw01-policy_rule_collection_10_0_0_0__24