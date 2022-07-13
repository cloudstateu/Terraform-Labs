data "azuread_client_config" "current" {}

output "object_id" {
  value = data.azuread_client_config.current.object_id
}

output "tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}

resource "random_password" "user01-password" {
  length  = 20
  special = true
}

resource "azuread_user" "user01" {
  user_principal_name = local.user_name
  display_name        = "J. Doe"
  mail_nickname       = "jdoe"
  password            = random_password.user01-password.result
}

output "object_id_user01" {
  value = azuread_user.user01.object_id
}