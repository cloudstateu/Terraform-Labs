variable "sub_id" {
  type        = string
  default     = "72ae933f-dab5-4a35-861e-1db14caba401"
}

# Wyłącznie dla celów zadaniowych, nie powinno się tak trzymać danych poufnych
variable "username" {
  type        = string
  default     = "mateusz"
  sensitive   = true
}

# Wyłącznie dla celów zadaniowych, nie powinno się tak trzymać danych poufnych
variable "password" {
  type        = string
  default     = "rlystrongpass!123"
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  default     = {
      owner = "Mateusz",
      start_date = "25.09.2021",
      course = "Terraform"
  }
}