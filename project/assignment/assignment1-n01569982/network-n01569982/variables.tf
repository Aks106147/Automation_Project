variable "location" {
  description = "The location where the resources will be deployed."
}

variable "resource_group_name" {
  description = "The name of the resource group where the resources will be deployed."
}

variable "vnet_name_prefix" {
  description = "The prefix for the name of the virtual network."
}

variable "address_space" {
  description = "The address space used for the virtual network."
  default     = ["10.0.0.0/16"]
}

variable "tags" {
  description = "Tags to be assigned to the resources."
}

variable "subnet_name_prefix" {
  description = "The prefix for the name of the subnet."
}

variable "subnet_address_space" {
  description = "The address space used for the subnet."
  default     = ["10.0.1.0/24"]
}

variable "security_group_name_prefix" {
  description = "The prefix for the name of the network security group."
}
