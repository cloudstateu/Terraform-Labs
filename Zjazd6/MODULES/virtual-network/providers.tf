terraform {
  required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = "2.90.0"
          
          #configuration_aliases = [ azurerm.dev-sub ]

      }
  }
}