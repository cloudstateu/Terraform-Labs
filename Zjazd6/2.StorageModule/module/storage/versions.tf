#https://www.terraform.io/language/modules/develop/providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.13"
    }
  }
}
