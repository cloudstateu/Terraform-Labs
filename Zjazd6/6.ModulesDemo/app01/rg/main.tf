provider "azurerm" {
  alias           = "provider-devenv-sub"
  subscription_id = var.devenv-sub
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azurerm" {
  subscription_id = var.default-sub
  features {

  }
}

provider "azuread" {
  # Configuration options
}

