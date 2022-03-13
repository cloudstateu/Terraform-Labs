###
### TODO: Setup Your provider
###
provider "azurerm" {
  subscription_id = var.defaultsub
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  client_id       = var.client_id 
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id 
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
