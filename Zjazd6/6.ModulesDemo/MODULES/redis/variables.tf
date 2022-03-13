# TODO: Wersja Premium - dopuszczona czy nie
variable "rg_name" {
    type        = string
    description = "Nazwa Resource Group gdzie tworzony jest Redis"
}

variable "redis_name" {
    type        = string
    description = "Nazwa instacji Redis"
}

variable "private_static_ip_address" {
    type        = string
    description = "Okreslenie prywatnego statycznego adresu IP dla instancji Redis."
}


variable "subnet_id" {
    type        = string
    description = "Tylko dla Premium. ID Subnetu, w ktorym zostanie utworzony Redis. W subnet moga byc tylko obiekty typu Redis Cache."
}

variable "shard_count" {
    type        = number
    description = "Tylko dla Premium. Okresla liczbe shards, ktore zostana ustawione w Redis"
}

variable "patch_schedule" {

    type            = object({
        day_of_week     = string
        start_hour_utc  = string
    })
}

variable "redis_configuration_maxmemory_reserved" {

    description = "Okresla rozmiar pamieci w MB, zarezerwowany wykorzystywany do funkcjonalnosci innej niz cache. "
    type        = string

}

variable "redis_configuration_maxmemory_delta" {

    description = "Okresla rozmiar pamieci typu Delta w MB."
    type        = string

}

variable "redis_configuration_maxmemory_policy" {

    description = "Okresla polityke gdy wykorzystanie pamieci na Redis osiagnie zdefiniowane maximum."
    type        = string

}

variable "redis_configuration_maxfragmentationmemory_reserved" {

    description = "Okresla w ilosc RAM w celu obsluzenie fragmentacji pamieci."
    type        = string

}

variable "redis_configuration_rdb_backup_enabled" {

    description = "Tylko Premium SKU. Okresla czy backup jest wlaczony. UWAGA!!! Jezeli ustawiony jest na true, trzeba ustawic rdb_storage_connection_string"
    type        = bool

}


variable "redis_configuration_rdb_storage_connection_string" {

    description = "Tylko Premium SKU. Connection String do storage account na ktory bedzie robiony backup. Format: DefaultEndpointsProtocol=https;BlobEndpoint=BLOB-ENDPOINT;AccountName=ACCOUNT-NAME;AccountKey=ACCOUNT-KEY" 
    type        = string

}

variable "redis_configuration_rdb_backup_frequency" {

    description = "Tylko Premium SKU. Okreslenia jak czesto wykonywany jest zapis / backup. Okres czasu jest wyrazony w minutach. Dopuszczalne wartosci:  15, 30, 60, 360, 720, 1440" 
    type        = number

}
 
variable "redis_configuration_rdb_backup_max_snapshot_count" {

    description = "Tylko Premium SKU. Maksymalna liczba snapshotow wykorzystywanych jako backup" 
    type        = number

}

variable "redis_configuration_notify_keyspace_events" {

    description = "Tylko Premium SKU. Ustawienie okreslajace czy pozwolono na podlaczenie klientow do pub/sub celem odebrania zmian zwiazanych z datasetami po stronie Redis" 
    type        = string
}

variable "redis_metrics_enabled" {
    description = "Ustawienie okreslajace czy metryki redisa maja byc zbierane" 
    type        = bool
}

variable "redis_metrics_log_analytics_rg_name" {
    description = "Nazwa Resource Group w ktorym znajduje sie Log Analytics Workspace" 
    type        = string
}

variable "redis_metrics_log_analytics_name" {
    description = "Nazwa Log Analytics Workspace do ktorego maja byc wysylane metryki" 
    type        = string
}