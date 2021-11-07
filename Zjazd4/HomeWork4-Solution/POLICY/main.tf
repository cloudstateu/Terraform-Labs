variable "subscription-id" {
  default = "ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
}

provider "azuread" {
  # Configuration options
}

provider "azurerm" {
  features {
  }
  # Configuration options
}