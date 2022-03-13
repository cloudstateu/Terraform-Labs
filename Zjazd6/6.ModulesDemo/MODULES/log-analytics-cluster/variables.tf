variable "rg_name" {
    description = "Nazwa Resource Group w ktorej utworzony zostanie obiekt Log Analytics Cluster"
    type        = string

}

variable "name" {
    description = "Nazwa obiektu Log Analytics Cluster"
    type        = string

}

variable "size_gb" {
    description = "Ustawienie okreslajace ilosc danych zapisywanych do klastra per dzien"
    type        = number
}

variable "custom_key" {
    description = "Ustawienie okreslajace czy klaster ma byc zaszyfrowany kluczem klienta"
    type        = bool  
}

variable "key_id" {
    description = "ID klucza znajdujacego sie w Key Vault, ktory ma byc wykorzystany do szyfrowania klastra Log Analytics"
    type        = string
}

