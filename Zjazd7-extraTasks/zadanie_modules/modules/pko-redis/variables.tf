variable "resource-group-name" {
  description = "Resouce group to which Redis should be deployed"
}

variable "redis-name" {
  description = "Name of Redis"
}

variable "redis-capacity" {
  default = "2"
}

variable "redis-subnet-id" {
  description = "ID of subnet to connect redis to"
}