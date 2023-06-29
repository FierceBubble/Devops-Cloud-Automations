# - - - - - Azure RG Variables - - - - - #
variable "rg_name" {
  description = "Azure Resource Group name"
}

variable "rg_location" {
  description = "Azure Resource Group location"
}

# - - - - - Azure NSG Variables - - - - - #
variable "azure_nsg_name" {
  description = "Azure VM Network Security Group name"
  default     = "nsg"
}
