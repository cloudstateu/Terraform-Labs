# NOTE: Korzystac tylko jak to jest konieczne
resource "azuread_application" "ab_application" {

    name                       = var.service_principal_object.name
    homepage                   = "https://${var.service_principal_object.name}"
    identifier_uris            = [ "https://${var.service_principal_object.name}" ]
    
    available_to_other_tenants = false
    public_client              = false

    oauth2_allow_implicit_flow = false
    
    oauth2_permissions {	
        admin_consent_description   = "Allow the application to access ${var.service_principal_object.name} on behalf of the signed-in user."
        admin_consent_display_name  = "Access ${var.service_principal_object.name}"
        is_enabled                  = true
        type                        = "User"
        user_consent_description    = "Allow the application to access ${var.service_principal_object.name} on your behalf."
        user_consent_display_name   = "Access ${var.service_principal_object.name}"
        value                       = "user_impersonation"
    }
    
    prevent_duplicate_names     = true
    owners                      = []
    type                        = "webapp/api"

    reply_urls                  = []
    logout_url                  = null

    group_membership_claims     = null

}


resource "azuread_application_password" "ab_application_password_end_date" {
    count                 = (var.service_principal_object.end_date != null && var.service_principal_object.end_date != "") ? 1 : 0
    
    application_object_id = azuread_application.ab_application.id
    
    value                 = var.service_principal_object.password
    end_date              = var.service_principal_object.end_date
}

resource "azuread_application_password" "ab_application_password_end_date_relative" {
    count                       = (var.service_principal_object.end_date_relative != null && var.service_principal_object.end_date_relative != "") ? 1 : 0

    application_object_id       = azuread_application.ab_application.id

    
    value                       = var.service_principal_object.password
    end_date_relative           = var.service_principal_object.end_date_relative
    
}

resource "azuread_service_principal" "ab_service_principal" {

    application_id              = azuread_application.ab_application.application_id

    tags = [ "service-principal-dla-application-${var.service_principal_object.name}"]
}

data "azurerm_resource_group" "resource_group" {
    count                       = (var.service_principal_object.rg_name != null && var.service_principal_object.rg_name != "") ? 1 : 0
    name                        = var.service_principal_object.rg_name
}

resource "azurerm_role_assignment" "ab_builtin_role_assignment" {
    for_each                   = toset(var.service_principal_object.builtin_roles)

    scope                      = data.azurerm_resource_group.resource_group[0].id

    role_definition_name       = each.key
    principal_id               = azuread_service_principal.ab_service_principal.id
}

resource "azurerm_role_assignment" "ab_custom_role_assignment" {
    for_each                   = toset(var.service_principal_object.custom_roles)

    scope                      = data.azurerm_resource_group.resource_group[0].id

    role_definition_name       = each.key
    principal_id               = azuread_service_principal.ab_service_principal.id
}

