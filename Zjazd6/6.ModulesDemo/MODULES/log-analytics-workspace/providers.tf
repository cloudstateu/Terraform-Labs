# provider "azurerm" {
#     alias = "provider-diagnostic"
# }

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">2.77.0"
      configuration_aliases = [ azurerm.provider-diagnostic ]
    }
  }
}
