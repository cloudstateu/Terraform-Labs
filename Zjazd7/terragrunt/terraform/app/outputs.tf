output "fqdn" {
  value = azurerm_app_service.app-svc-webapp.default_site_hostname
}
