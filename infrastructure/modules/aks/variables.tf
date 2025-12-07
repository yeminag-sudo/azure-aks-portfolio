variable "resource_group_name" {}
variable "location" {}
variable "environment" {}
variable "vnet_subnet_id" {
  description = "The Subnet ID where the AKS nodes will be placed"
}