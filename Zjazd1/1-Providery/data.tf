data "azuread_user" "my_user_data" {
  user_principal_name = "bank-student0@chmurowiskolab.onmicrosoft.com"
}

data "azurerm_resource_group" "main_rg" {
  name = "bank-student0"
}
