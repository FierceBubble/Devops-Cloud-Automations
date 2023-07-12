# - - - - - Azure RG Variables - - - - - #
variable "rg_name" {
  description = "Azure Resource Group name"
}

variable "rg_location" {
  description = "Azure Resource Group location"
}

# - - - - - Azure VNet Variables - - - - - #
variable "vnet_id" {
  description = "Azure VNet id"
}

variable "azure_subnet_id" {
  description = "Azure Subnet id"
}

# - - - - - Azure Load Balancer Variables - - - - - #
variable "azure_lb_name" {
  description = "Azure LB name"
  default     = "LB-TF"
}

variable "azure_lb_ipconfig_name" {
  description = "Azure LB ipconfig name"
  default     = "LB-ipconfig"
}
