variable "rg_name" {
    description = "Nazwa Resource Group w ktorej utworzony zostanie obiekt Log Analytics Workspace"
    type        = string

}

variable "name" {
    description = "Nazwa obiektu Log Analytics Workspace"
    type        = string

}

variable "retention_in_days" {
    description = "Ustawienie retencji dla danych w Log Analytics Workspace. Wartosc wyrazona w dniach, pomiedzy 30, a 730."
    type        = number
}

variable "internet_ingestion_enabled" {
    description = "Ustawienie okreslajace czy dane moga byc wysylane do Log Analytics Workspace poprzez Internet"
    type        = bool  
}

variable "internet_query_enabled" {
    description = "Okresla czy zapytanie moga byc wysylane do Log Analytics Workspace przez Internet"
    type        = bool
}

variable "link_to_la_cluster" {
    description = "Okresla czy Log Analytics Workspace ma być podłączony do klastra Log Analytics"
    type        = bool
}
variable "la_cluster_id" {
    description = "ID klastra Log Analytics to ktorego ma zostac dolaczona Log Analytics Workspace"
    type        = string
}