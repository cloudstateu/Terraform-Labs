###
### TODO: Setup Your provider
###
provider "azurerm" {
  subscription_id = "ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azuread" {
  # Configuration options
}

###
### TODO - Backend params
### 

#terraform {
#  backend "azurerm" {
#    storage_account_name = "<ACCOUNT NAME>" 
#    container_name       = "<CONTAINER>" 
#    key                  = "cloudeng.shared.terraform.tfstate"  
#    access_key  = 
#  }
#}
