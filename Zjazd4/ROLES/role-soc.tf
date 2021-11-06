resource "azurerm_role_definition" "chm-secops-soc-line1" {
  name        = "chm-secops-soc-line1"
  #TODO
  provider    = azurerm.provider-transit-prod
  #TODO
  scope       =  "/providers/Microsoft.Management/managementGroups/${data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id}"
  description = "chm-secops-soc-line1"

  permissions {
    actions   = [
                    "Microsoft.SecurityInsights/*/read",
                    "Microsoft.SecurityInsights/dataConnectorsCheckRequirements/action",
                    "Microsoft.SecurityInsights/cases/*",
                    "Microsoft.SecurityInsights/incidents/*",
                    "Microsoft.SecurityInsights/threatIntelligence/indicators/appendTags/action",
                    "Microsoft.SecurityInsights/threatIntelligence/indicators/query/action",
                    "Microsoft.SecurityInsights/threatIntelligence/bulkTag/action",
                    "Microsoft.SecurityInsights/threatIntelligence/indicators/appendTags/action",
                    "Microsoft.SecurityInsights/threatIntelligence/indicators/replaceTags/action",
                    "Microsoft.SecurityInsights/threatIntelligence/queryIndicators/action",
                    "Microsoft.OperationalInsights/workspaces/analytics/query/action",
                    "Microsoft.OperationalInsights/workspaces/read",
                    "Microsoft.OperationalInsights/workspaces/query/Heartbeat/read",
                    "Microsoft.OperationalInsights/workspaces/query/AzureActivity/read",
                    "Microsoft.OperationalInsights/workspaces/query/SigninLogs/read",
                    "Microsoft.OperationalInsights/workspaces/dataSources/read",
                    "Microsoft.OperationalInsights/workspaces/savedSearches/read",
                    "Microsoft.OperationsManagement/solutions/read",
                    "Microsoft.OperationalInsights/workspaces/dataSources/read",
                    "Microsoft.OperationalInsights/workspaces/search/action",
                    "Microsoft.OperationalInsights/*/read",
                    "Microsoft.Insights/workbooks/read",
                    "Microsoft.Insights/myworkbooks/read",
                    "Microsoft.Authorization/*/read",
                    "Microsoft.Resources/deployments/*",
                    "Microsoft.Resources/subscriptions/resourceGroups/read"
      ]
    not_actions = [
      "Microsoft.SecurityInsights/cases/*/Delete",
      "Microsoft.SecurityInsights/incidents/*/Delete",
      "Microsoft.OperationalInsights/workspaces/sharedKeys/read"
    ]
  }
  #TODO
  assignable_scopes = [
    "/providers/Microsoft.Management/managementGroups/${data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id}"
  ]
}

# Rola ma dostęp do wszystkich table w Log Analytics,
# Rola ma dostęp w trybie Read to Security Center
# Rola ma R/W do Sentinel - moze zarządzać konfigurację Sentinela
# Rola nie moze tworzyc plabook'ow ani zarządzac przypisaniem plabook'ow
resource "azurerm_role_definition" "chm-secops-soc-line2" {
  name        = "chm-secops-soc-line2"
  #TODO
  provider    = azurerm.provider-transit-prod
  #TODO
  scope       =  "/providers/Microsoft.Management/managementGroups/${data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id}"
  description = "chm-secops-soc-line2"

  permissions {
    actions   = [
                    "Microsoft.OperationalInsights/workspaces/query/read",
                    "Microsoft.OperationalInsights/workspaces/query/*/read",
                    "Microsoft.OperationalInsights/workspaces/dataSources/read",
                    "Microsoft.OperationsManagement/solutions/read",
                    "Microsoft.Security/*/read",
                    "Microsoft.SecurityInsights/*",
                    "Microsoft.OperationalInsights/*/read",
                    "Microsoft.OperationalInsights/workspaces/analytics/query/action",
                    "Microsoft.OperationalInsights/workspaces/savedSearches/*",
                    "Microsoft.OperationalInsights/workspaces/search/action",
                    "Microsoft.OperationalInsights/workspaces/analytics/query/action",
                    "Microsoft.OperationalInsights/workspaces/LinkedServices/read",
                    "Microsoft.OperationalInsights/workspaces/savedSearches/read",
                    "Microsoft.Insights/workbooks/*",
                    "Microsoft.Insights/myworkbooks/read",
                    "Microsoft.Authorization/*/read",
                    "Microsoft.Insights/alertRules/*",
                    "Microsoft.Resources/deployments/*",
                    "Microsoft.Resources/subscriptions/resourceGroups/read",
                    "Microsoft.Support/*"
      ]
    not_actions = [
      "Microsoft.SecurityInsights/cases/*/Delete",
      "Microsoft.SecurityInsights/incidents/*/Delete",
      "Microsoft.SecurityInsights/automationRules/*/Delete",
      "Microsoft.OperationalInsights/workspaces/sharedKeys/read"
    ]
  }
  #TODO
  assignable_scopes = [
    "/providers/Microsoft.Management/managementGroups/${data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id}"
  ]
}


# Security Center - R/W
# Sentinel - R/W
# SOAR (Logic App) - R/W
# Log Analytics - pelen dostp do tabel


resource "azurerm_role_definition" "chm-secops-soc-line3" {
  name        = "chm-secops-soc-line3"
  #TODO
  provider    = azurerm.provider-transit-prod
  #TODO
  scope       =  "/providers/Microsoft.Management/managementGroups/${data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id}"
  description = "chm-secops-soc-line3"

  permissions {
    actions   = [
                    "Microsoft.SecurityInsights/*",
                    "Microsoft.Security/*",
                    "Microsoft.OperationalInsights/workspaces/analytics/query/action",
                    "Microsoft.OperationalInsights/workspaces/*/read",
                    "Microsoft.OperationalInsights/workspaces/savedSearches/*",
                    "Microsoft.OperationsManagement/solutions/read",
                    "Microsoft.OperationalInsights/workspaces/query/read",
                    "Microsoft.OperationalInsights/workspaces/query/*/read",
                    "Microsoft.OperationalInsights/workspaces/dataSources/read",
                    "Microsoft.Authorization/*/read",
                    "Microsoft.Insights/workbooks/*",
                    "Microsoft.Insights/myworkbooks/read",
                    "Microsoft.Insights/alertRules/*",
                    "Microsoft.Insights/metricAlerts/*",
                    "Microsoft.Insights/diagnosticSettings/*",
                    "Microsoft.Insights/logdefinitions/*",
                    "Microsoft.Insights/metricDefinitions/*",
                    "Microsoft.Logic/*",
                    "Microsoft.Resources/deployments/*",
                    "Microsoft.Resources/subscriptions/operationresults/read",
                    "Microsoft.Resources/subscriptions/resourceGroups/read",
                    "Microsoft.Storage/storageAccounts/listkeys/action",
                    "Microsoft.Storage/storageAccounts/read",
                    "Microsoft.Support/*",
                    "Microsoft.Web/connectionGateways/*",
                    "Microsoft.Web/connections/*",
                    "Microsoft.Web/customApis/*",
                    "Microsoft.Web/serverFarms/join/action",
                    "Microsoft.Web/serverFarms/read",
                    "Microsoft.Web/sites/functions/listSecrets/action"
      ]
    not_actions = []
  }
  #TODO
  assignable_scopes = [
    "/providers/Microsoft.Management/managementGroups/${data.azurerm_subscriptions.SUB-GLOBAL.subscriptions[0].tenant_id}"
  ]
}