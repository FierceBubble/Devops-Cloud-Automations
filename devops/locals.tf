locals {
  root_dir        = dirname(abspath(path.root))
  k8s_config_dir  = "${local.root_dir}/.kube"
  k8s_config_file = "${local.k8s_config_dir}/kubeconfig.yaml"
  private_key     = sensitive(file("~/.ssh/azure_key"))
  public_key      = sensitive(file("~/.ssh/azure_key.pub"))
}
