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
    ansible_ssh_private_key_file = "${local.root_dir}/devops/ssh/ssh-key"
  }
}

resource "ansible_group" "worker_group" {
  depends_on = [local_file.ansible_vars_tf]
  name       = "worker"
  # children = module.network.worker-private-ip
  variables = {
    ansible_ssh_common_args = "-o ProxyCommand=\"ssh -W %h:%p -q ${var.azure_admin_username}@${azurerm_linux_virtual_machine.vm.public_ip_address}\""
  }
}

resource "ansible_host" "worker" {
  depends_on = [ansible_group.worker_group]
  count      = var.worker_vm_count
  name       = module.network.worker-private-ip[count.index]
  groups     = [ansible_group.worker_group.name]
  # groups = ["worker"]

  variables = {
    ansible_user                 = var.azure_admin_username
    ansible_ssh_private_key_file = "${local.root_dir}/devops/ssh/ssh-key"
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

resource "time_sleep" "local-exec-provisioner" {
  depends_on = [ansible_host.worker]
  provisioner "local-exec" {
    when        = create
    working_dir = local.root_dir
    # command     = "make inventory && make ping-master && make local-update-ssh-config && make remote-update-apt && make master-update-ssh-config && make ping && make worker-setup"
    command = <<EOT
      make inventory
      make local-update-ssh-config
      make ping-master
      make master-update-ssh-config
      make all-update-apt
      make ping
      make kubernetes-init
      make local-add-kubeconfig
    EOT
  }
  create_duration = "5s"
}

# resource "null_resource" "copy-private_key-master" {
#   depends_on = [time_sleep.local-exec-provisioner]
#   count      = var.worker_vm_count
#   connection {
#     host        = azurerm_linux_virtual_machine.vm.public_ip_address
#     type        = "ssh"
#     user        = var.azure_admin_username
#     private_key = tls_private_key.ssh.private_key_openssh
#     agent       = "false"
#   }
#   provisioner "file" {
#     source      = "${local.root_dir}/devops/ssh/ssh-key"
#     destination = ".ssh/"
#   }

#   provisioner "file" {
#     content     = "Host ${module.network.worker-private-ip[count.index]}\n  HostName ${module.network.worker-private-ip[count.index]}  IdentityFile ~/.ssh/ssh-key"
#     destination = ".ssh/config"
#   }
# }
