data "azuread_user" "my_user_data" {
  user_principal_name = "mateusz.zadrozny_chmurowisko.pl#EXT#@chmfnd.onmicrosoft.com"
}

data "azurerm_resource_group" "main_rg" {
  name = "LabResourceGroup"
}