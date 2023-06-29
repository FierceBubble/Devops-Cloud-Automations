resource "local_file" "kubeconfig" {
  content         = "Kubeconfig not initialized!"
  filename        = var.kubeconfig_path
  file_permission = "0600"
}
