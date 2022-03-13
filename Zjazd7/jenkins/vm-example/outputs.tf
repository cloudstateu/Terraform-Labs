output "ip" {
  value = azurerm_public_ip.ip.ip_address
}

output "password" {
  value = random_password.password.result
}
