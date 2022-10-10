terraform {
  backend "azurerm" {
    key = "__backend_key__"
    resource_group_name  = "__sa_rg_name__"
    storage_account_name = "__sa_name__"
    container_name       = "__sa_container_name__"
    subscription_id      = "__sa_subscription_id__"
  }
}
