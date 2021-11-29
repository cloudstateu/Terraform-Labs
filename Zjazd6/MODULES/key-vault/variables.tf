variable "rg_name" {
    description = "Nazwa Resource Group w ktorej utworzony zostanie obiekt Key Vault"
    type        = string

}

variable "name" {
    description = "Nazwa obiektu Key Vault"
    type        = string

}

variable "sku" {
    description = "SKU dla Key Vault. Dopuszczone tylko standard i premium. Mozliwe wartosci to standard i premium."
    type        = string
}

variable "tenant_id" {
    description = "Tenant ID Azure Active Directory, ktory bedzie wykorzystywany do uwierzytelnienia dostepu do Key Vault"
    type        = string  
}

variable "enabled_for_deployment" {
    description = "Okresla czy maszyny wirtualne moga pobrac certyfikaty przechowywane w Key Vault."
    type        = bool
}

variable "enabled_for_disk_encryption" {
    description = "Okresla czy Key Vault moze byc wykorzystywany do funkcjonalnosci Azure Disk Encryption. Jezeli wartosc jest ustawiona true to Azure Disk Encryption moze pobrac klucze z Key Vaulta"
    type        = bool
}

variable "enabled_for_template_deployment" {
    description = "Okresla czy Key Vault moze byc wykorzystywany przez Azure Resource Manager, co pozwala Azure Resource Manager na odczyt sekretow z Key Vault."
    type        = bool
}

variable "enable_rbac_authorization" {
    description = "Okresla czy Key Vault wykorzystuje Role Based Access Control (RBAC) do autoryzacji."
    type        = bool
}

variable "purge_protection_enabled" {
    description = "Okresla czy Key Vault ma wlaczona funkcjonalnosc Purge Protection. 
    type        = bool
}

variable "soft_delete_retention_days" {
    description = "Okresla ilosc dni dla funkcjonalnosci soft delete, czyli liczby dni po ktorych dane z Key Vaulta zostana pernamentnie. Moze przyjmowac wartosc pomiedzy 7 a 90 dni. 
    type        = number
}

variable "network_acls_bypass" {
    description = "Okresla czy AzureServices moga pominac reguly firewall skonfigurowane na Key Vault. Mozliwe wartosci to AzureServices lub None"
    type        = string
}

variable "network_acls_ip_list" {
    description = "Lista adresow IP lub subnetow z ktorych mozna odwolac sie do Key Vault"
    type        = list(string)
}

variable "network_acls_subnet_ids" {
    description = "Adres email do ustawienia jako czesc kontaktu w Key Vault"
    type        = list(string)
}

variable "contact_email" {
    description = "Adres email do ustawienia jako czesc kontaktu w Key Vault"
    type        = string
}

variable "contact_name" {
    description = "Nazwa kontaktu do ustawienia jako czesc kontaktu w Key Vault"
    type        = string
}

variable "contact_phone" {
    description = "Numer telefonu do ustawienia jako czesc kontaktu w Key Vault"
    type        = string
}

variable "log_analytics" {
    description = "Nazwa Log Analytics Workspace do ktorego beda przekazywane zdarzenia z Key Vault"
    type        = string
}

variable "log_analytics_rg" {
    description = "Nazwa Resource Group w ktorym jest Log Analytics Workspace"
    type        = string
}
