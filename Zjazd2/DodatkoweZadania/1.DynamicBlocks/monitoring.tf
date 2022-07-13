resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-logs"
  location            = data.azurerm_resource_group.main_rg.location
  resource_group_name = data.azurerm_resource_group.main_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

#data "azurerm_monitor_diagnostic_categories" "categories" {
#  resource_id = azurerm_firewall.firewall.id
#}
#
#output "diagnostic_categories" {
#  value = data.azurerm_monitor_diagnostic_categories.categories
#}

variable "firewall_diagnostic_categories" {
  type = map(object({
    enabled = bool
  }))
  default = {
    "AZFWApplicationRule" = {
      enabled = true,
    }
    "AZFWApplicationRuleAggregation" = {
      enabled = false
    }
    "AZFWDnsQuery" = {
      enabled = false
    }
    "AZFWFqdnResolveFailure" = {
      enabled = false
    }
    "AZFWIdpsSignature" = {
      enabled = false
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "firewall-ds" {
  name               = "firewall-ds"
  target_resource_id = azurerm_firewall.firewall.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  dynamic "log" {
    for_each = var.firewall_diagnostic_categories
    content {
      category = log.key
      enabled  = log.value.enabled
    }
  }
}
