# - - - - - Linode Variables - - - - - #
variable "linode_token" {
  description = "Linode API Token"
  sensitive   = true
}

# - - - - - Cloudflare Variables - - - - - #
variable "cloudflare_api_key" {
  description = "Cloudflare API Key"
  sensitive   = true
}

variable "cloudflare_email" {
  description = "Cloudflare Email"
}

# - - - - - Azure Variables - - - - - #
variable "azure_subscription_id" {
  description = " Azure Subscription ID"
  sensitive   = true
}

variable "azure_tenant_id" {
  description = " Azure Tenant ID"
  sensitive   = true
}

# - - - - - Azure Resource Group Variables - - - - - #
variable "azure_rg_name" {
  description = "Azure RG name"
  default     = "RG-TF"
}

variable "azure_rg_location" {
  description = "Azure RG location (Region)"
  default     = "East Asia"
}

# - - - - - Azure Availability Set Variables - - - - - #
variable "azure_availability_set_name" {
  description = "Azure AS name"
  default     = "TF-avlbset"
}

# - - - - - Azure VM Variables - - - - - #
variable "azure_vm_name" {
  type        = string
  description = "Azure VM name"
  default     = "Master-Node"
}

variable "azure_vm_host_name" {
  type        = string
  description = "Azure VM host name"
  default     = "master-node"
}

variable "azure_vm_size" {
  description = "Azure VM size"
  default     = "Standard_D2s_v3"
}

variable "azure_vm_disable_password" {
  description = "Azure VM disable password"
  default     = "false"
}

variable "azure_admin_username" {
  type        = string
  nullable    = false
  description = "Admin username to VM"
}

variable "azure_admin_password" {
  type        = string
  nullable    = false
  description = "Admin password to VM"
  sensitive   = true
}

variable "azure_vm_os_disk_type" {
  description = "Azure VM OS Disk type"
  default     = "Standard_LRS"
}

variable "azure_vm_os_disk_caching" {
  description = "Azure VM OS Disk caching option"
  default     = "ReadWrite"
}

variable "azure_vm_os_disk_size" {
  type        = map(number)
  description = "Azure VM OS Disk size (GB)"
  default = {
    "master" = 50
    "worker" = 35
  }
}

variable "azure_vm_image_publisher" {
  description = "Azure VM Image Publisher"
  default     = "Canonical"
}

variable "azure_vm_image_offer" {
  description = "Azure VM Image Offer"
  default     = "0001-com-ubuntu-server-focal"
}

variable "azure_vm_image_sku" {
  description = "Azure VM Image SKU"
  default     = "20_04-lts"
}

variable "azure_vm_image_version" {
  description = "Azure VM Image Version"
  default     = "latest"
}

# Ubuntu 22.04 LTS Image
# Cannonical
# 0001-com-ubuntu-server-jammy
# 22_04-lts-gen2
# latest

# Ubuntu 20.04 LTS Image
# Canonical
# 0001-com-ubuntu-server-focal
# 20_04-lts
# latest

# Ubuntu 18.04 LTS Image
# Cannonical
# UbuntuServer
# 18.04-LTS 
# latest

# - - - - - Dynamic Variables - - - - - #
variable "worker_vm_count" {
  type        = number
  description = "Total number of worker nodes"
  default     = 1
  validation {
    condition     = var.worker_vm_count >= 1
    error_message = "Worker nodes should be 1 or more!"
  }
}

# - - - - - Local Variables - - - - -
variable "local_admin_username" {
  type        = string
  nullable    = false
  description = "Admin userame to Local"
}

variable "local_admin_pass" {
  type        = string
  nullable    = false
  description = "Admin password to Local"
  sensitive   = true
}
