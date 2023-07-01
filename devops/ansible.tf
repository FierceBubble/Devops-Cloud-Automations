# resource "ansible_vault" "secrets" {
#   vault_file          = ".ansible/vault.yml"
#   vault_password_file = "./ansible/password"
# }

resource "ansible_host" "local" {
  name   = "127.0.0.1"
  groups = ["local"]
  variables = {
    ansible_connection  = "local"
    ansible_become_pass = var.local_admin_pass
  }
}

resource "ansible_host" "master" {
  name   = azurerm_linux_virtual_machine.vm.public_ip_address
  groups = ["master"]
  variables = {
    ansible_user                 = var.azure_admin_username
    ansible_ssh_private_key_file = local.private_key
    # ansible_python_interpolator  = local.python_interpolator_path
    # yaml_secret                  = local.decoded_vault_yml.sensitive
  }
}

# resource "ansible_playbook" "local-update-ssh-config" {
#   playbook   = "./ansible/playbook/local-update-ssh-config.yaml"
#   name       = "local"
#   replayable = true

#   extra_vars = {
#     local_username              = var.local_admin_username
#     master_node_public_ip       = azurerm_linux_virtual_machine.vm.public_ip_address
#     master_node_ssh_private_key = local.private_key
#   }
# }
