output "storage-key" {
    value = azurerm_storage_account.example.primary_access_key
    sensitive = "true"
}

data "template_file" "init" {
    template = "${file("init.tpl")}"
    vars = {
        my_storage_access_key = azurerm_storage_account.example.primary_access_key
        my_storage_url = azurerm_storage_account.example.primary_blob_endpoint
    }
}

output "ourfile" {
    value = data.template_file.init.rendered
}