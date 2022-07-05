resource "azurerm_public_ip" "firewall-ip" {
  name                = "firewall-ip"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall_policy" "firewall-policy" {
  name                = "firewall-policy"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
}

resource "azurerm_firewall_policy_rule_collection_group" "rules" {
  firewall_policy_id = azurerm_firewall_policy.firewall-policy.id
  name               = "default"
  priority           = 100

  network_rule_collection {
    action   = "Allow"
    name     = "default"
    priority = 100
    rule {
      destination_ports     = ["22"]
      name                  = "allowSSH"
      destination_addresses = ["*"]
      source_addresses      = ["*"]
      protocols             = ["TCP"]
    }
  }
}

resource "azurerm_firewall" "firewall" {
  name                = "hubfirewall"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  firewall_policy_id  = azurerm_firewall_policy.firewall-policy.id
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "firewallconfiguration"
    subnet_id            = azurerm_subnet.vnet-hub-firewall-subnet.id
    public_ip_address_id = azurerm_public_ip.firewall-ip.id
  }
}
