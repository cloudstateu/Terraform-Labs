

module "log-analytics-dev" {

  source = "../../MODULES/log-analytics-workspace"

  providers = {
    azurerm.provider-diagnostic = azurerm.provider-devenv-sub
  }

  rg_name                    = data.azurerm_resource_group.monitoring-dev-rg.name
  retention_in_days          = 30
  internet_ingestion_enabled = true
  internet_query_enabled     = true
  link_to_la_cluster         = false
  la_cluster_id              = ""
  name                       = "devloganal01"

}