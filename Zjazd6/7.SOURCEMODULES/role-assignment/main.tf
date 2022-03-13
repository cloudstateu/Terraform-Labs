data "azurerm_resource_group" "resource_group" {
    count                       = (var.principal_object.rg_name != null && var.service_principal_object.rg_name != "") ? 1 : 0
    name                        = var.principal_object.rg_name
}

resource "azurerm_role_assignment" "ab_builtin_role_assignment" {
    for_each                   = toset(var.principal_object.builtin_roles)

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
