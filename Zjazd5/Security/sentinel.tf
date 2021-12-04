resource "azurerm_resource_group" "sentinel-rg" {
  name     = "sentinel-rg"
  location = "West Europe"
}

resource "azurerm_log_analytics_workspace" "sentinel-loganalytics" {
  name                = "sentinel-loganalytics"
  location            = azurerm_resource_group.sentinel-rg.location
  resource_group_name = azurerm_resource_group.sentinel-rg.name
  sku                 = "pergb2018"
}

resource "azurerm_log_analytics_solution" "sentinel-loganalytics-solution" {
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.sentinel-rg.location
  resource_group_name   = azurerm_resource_group.sentinel-rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.sentinel-loganalytics.id
  workspace_name        = azurerm_log_analytics_workspace.sentinel-loganalytics.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}

resource "azurerm_sentinel_alert_rule_scheduled" "sentinel-rulescheduled" {
  name                       = "sentinel-rulescheduled"
  log_analytics_workspace_id = azurerm_log_analytics_solution.sentinel-loganalytics-solution.workspace_resource_id
  display_name               = "sentinel-rulescheduled"
  severity                   = "High"
  query                      = <<QUERY
AzureActivity |
  where OperationName == "Create or Update Virtual Machine" or OperationName =="Create Deployment" |
  where ActivityStatus == "Succeeded" |
  make-series dcount(ResourceId) default=0 on EventSubmissionTimestamp in range(ago(7d), now(), 1d) by Caller
QUERY
}

###
### SAMPLES
### CheckChangesInAzureAD Group: https://github.com/mifurm/secworkshop/blob/master/checkChangesOnAADGroup.kusto
