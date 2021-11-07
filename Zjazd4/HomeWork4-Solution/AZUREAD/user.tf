data "azuread_client_config" "current" {}

output "object_id" {
  value = data.azuread_client_config.current.object_id
}

output "tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}

data "azuread_user" "user01" {
   user_principal_name = "user01@michalfurmankiewiczhotmail.onmicrosoft.com"
}

output "object_id_user01" {
  value = data.azuread_user.user01.object_id
}