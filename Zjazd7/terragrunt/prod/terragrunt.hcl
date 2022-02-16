remote_state {
  backend = "azurerm"
  config  = {
    subscription_id      = "f0a8a162-c4e2-414c-a26f-acca3a81ac1a"
    resource_group_name  = "main"
    storage_account_name = "tfazstatestorage"
    container_name       = "terragrunt"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}
