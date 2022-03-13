

# subskrypcja pod sieć hub w ramach architektury hub-spoke
provider "azurerm" {
  alias = "provider-hub-env"
  subscription_id = var.hub-sub
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azurerm" {
    features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azuread" {
  # Configuration options
}

# subskrypcja pod środowisko dev
provider "azurerm" {
  alias = "provider-dev-env"
  subscription_id = var.dev-sub
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}