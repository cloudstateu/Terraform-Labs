variable "rg_name" {
    description = "Nazwa Resource Group w ktorej utworzony zostanie obiekt Cognitive Search Service"
    type        = string

}

variable "name" {
    description = "Nazwa obiektu Cognitive Search Service"
    type        = string

}

variable "sku" {
    description = "SKU Cognitive Search Service, Dopuszczamy standard, standard2, standard3"
    type        = string
}

variable "partition_count" {
    description = "Liczba partycji do wykorzystania w usludze Cognitive Search Services. Nalezy ustawic zgodnie z wymaganiami dla storage oraz wydajnosci"
    type        = string  
}

variable "replica_count" {
    description = "Liczba replik wykorzystywanych przez Cognitive Search Services, ustawiamy na na wartosc 3 ze względu na dostępność"
    type        = string
}

variable "subnet_id" {
    description = "ID subnetu w ktorym utworozny ma zostac Private Endpoint"
    type        = string
}

variable "log_analytics" {
    description = "Nazwa Log Analytics Workspace do ktorego beda przekazywane zdarzenia z Cognitive Search Service"
    type        = string
}

variable "log_analytics_rg" {
    description = "Nazwa Resource Group w ktorym jest Log Analytics Workspace"
    type        = string
}

