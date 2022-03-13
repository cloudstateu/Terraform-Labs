data "azurerm_management_group" "example" {
    display_name = "Tenant Root Group"
}


#  name = "00000000-0000-0000-0000-000000000000"


output "display_name" {
  value = data.azurerm_management_group.example.display_name
}

output "id" {
  value = data.azurerm_management_group.example.id
}