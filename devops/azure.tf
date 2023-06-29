resource "azurerm_resource_group" "rg" {
  name     = var.azure_rg_name
  location = var.azure_rg_location
}

module "network" {
  source            = "./modules/azure/network"
  rg_name           = azurerm_resource_group.rg.name
  rg_location       = azurerm_resource_group.rg.location
  count_worker_node = var.worker_vm_count
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.azure_vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.azure_vm_size
  computer_name       = var.azure_vm_host_name
  admin_username      = var.azure_admin_username

  network_interface_ids = [
    module.network.nic_id,
  ]

  admin_ssh_key {
    username   = var.azure_admin_username
    public_key = local.public_key
  }

  os_disk {
    caching              = var.azure_vm_os_disk_caching
    storage_account_type = var.azure_vm_os_disk_type
    disk_size_gb         = var.azure_vm_os_disk_size["master"]
  }

  source_image_reference {
    publisher = var.azure_vm_image_publisher
    offer     = var.azure_vm_image_offer
    sku       = var.azure_vm_image_sku
    version   = var.azure_vm_image_version
  }

}

resource "azurerm_linux_virtual_machine" "worker" {
  count = var.worker_vm_count

  name                            = "Worker-${count.index}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.azure_vm_size
  disable_password_authentication = var.azure_vm_disable_password
  computer_name                   = "worker-${count.index}"
  admin_username                  = var.azure_admin_username
  admin_password                  = var.azure_admin_password

  network_interface_ids = [
    module.network.worker-nic-ids[count.index],
  ]

  os_disk {
    caching              = var.azure_vm_os_disk_caching
    storage_account_type = var.azure_vm_os_disk_type
    disk_size_gb         = var.azure_vm_os_disk_size["worker"]
  }

  source_image_reference {
    publisher = var.azure_vm_image_publisher
    offer     = var.azure_vm_image_offer
    sku       = var.azure_vm_image_sku
    version   = var.azure_vm_image_version
  }
}

# - - - - - Kubernetes Provisioning - - - - -
module "k8s" {
  source          = "./modules/azure/kubernetes"
  kubeconfig_path = local.k8s_config_file
}
