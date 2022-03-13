data "azurerm_resource_group" "resource_group" {
    name                        = var.rg_permission_object.rg_name
}

resource "azurerm_role_assignment" "ab_builtin_role_assignment" {
    for_each                   = toset(var.rg_permission_object.builtin_roles)

    scope                      = data.azurerm_resource_group.resource_group.id

    role_definition_name       = each.key
    principal_id               = var.rg_permission_object.principal_id
}

resource "azurerm_role_assignment" "ab_custom_role_assignment" {
    for_each                   = toset(var.rg_permission_object.custom_roles)

    scope                      = data.azurerm_resource_group.resource_group.id

    role_definition_name       = each.key
    principal_id               = var.rg_permission_object.principal_id
}

