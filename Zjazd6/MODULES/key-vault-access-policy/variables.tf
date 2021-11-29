variable "key_vault_access_policy" {
    description =<<EOF
Obiekt opisujacy uprawnienia na KeyVault:
key_vault_id:                   ID Key Vault dla ktorego konfigurowane sa uprawnienia
tenant_id:                      ID Tenanta
object_id:                      Principal ID dla ktorego nadawane sa uprawnienia
certificate_permissions:        Lista uprawnienie na obiekty typu certyfikat. Dozwolona lista wartosci: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers, Update.
key_permissions:                Lista uprawnienie na obiekty typu klucz. Dozwolona lista wartosci: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey.
secret_permissions:             Lista uprawnienie na obiekty typu secret. Dozwolona lista wartosci: Backup, Delete, get, list, purge, recover, restore, set.
storage_permissions:            Lista uprawnienie na obiekty typu storage. Dozwolona lista wartosci: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update

EOF
    type        = object({
        key_vault_id                = string
        tenant_id                   = string
        object_id                   = string
        certificate_permissions     = list(string)
        key_permissions             = list(string)
        secret_permissions          = list(string)
        storage_permissions         = list(string)
    })
}
