variable "resource_group_tags_testrg" {}
variable "resource_group_object_testrg" {}

variable "resource_group_tags_devrg" {}
variable "resource_group_object_devrg" {}

variable "defaultsub" {}

variable "client_secret" {
    sensitive = "true"
}

variable "client_id" {}

variable "tenant_id" {}