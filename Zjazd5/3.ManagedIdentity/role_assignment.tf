resource "azurerm_role_assignment" "example" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.vm-identity.principal_id
}