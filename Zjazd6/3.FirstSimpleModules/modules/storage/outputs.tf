output "primary_key" {
    description = "The primary access key for the storage account"
    value = azurerm_storage_account.storageaccount.primary_access_key
    sensitive   = true
}

output "sa-replication-type" {
    value = azurerm_storage_account.storageaccount.account_replication_type
}