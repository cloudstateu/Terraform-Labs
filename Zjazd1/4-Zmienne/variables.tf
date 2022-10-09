variable "sub_id" {
  type        = string
  default     = "79283b62-f23b-4420-9ae7-1ac41de00335"
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
      start_date = "25.09.2022",
      course = "Terraform"
  }
}
