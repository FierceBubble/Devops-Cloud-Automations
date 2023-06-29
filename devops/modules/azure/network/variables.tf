# - - - - - Azure Resource Group Variables - - - - - #
variable "rg_name" {
  description = "Resource Group name"
}

variable "rg_location" {
  description = "Resource Group location"
}

# - - - - - Azure Vnet Variables - - - - - #
variable "azure_vnet_name" {
  description = "Azure VM Virtual Network name"
  default     = "vnet"
}

variable "azure_vnet_addr" {
  description = "Azure VM Virtual Network address space"
  default     = ["10.230.0.0/24"]
}

# - - - - - Azure Subnet Variables - - - - - #
variable "azure_subnet_name" {
  description = "Azure VM Subnet name"
  default     = "subnet"
}

variable "azure_subnet_prefixes" {
  description = "Azure VM Subnet address prefixes"
  default     = ["10.230.0.0/27"]
}

# - - - - - Azure NIC Variables - - - - - #
variable "azure_nic_ipconfig_name" {
  description = "Azure VM Network Interface IP config name"
  default     = "nic-ipconfig"
}

variable "azure_nic_privateip_version" {
  description = "Azure VM NIC Private IP Version"
  default     = "IPv4"
}

variable "azure_nic_privateip_allocation" {
  description = "Azure VM NIC Private IP config allocation"
  default     = "Static"
}

# - - - - - Dynamic Variables - - - - - #
variable "count_worker_node" {
  type        = number
  description = "Total worker node"
}

variable "azure_nic_master_privateip_addr" {
  default = "10.230.0.10"
}

variable "azure_nic_worker_privateip_addr" {
  default = "10.230.0.2"
}
