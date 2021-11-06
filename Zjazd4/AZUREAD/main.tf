terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "2.8.0"
    }
  }
}

provider "azuread" {
  # Configuration options
}
