module "deployment" {
  source          = "./deployments"
  app_name        = "nginx"
  container_image = "nginx:latest"
  container_port  = 80
  container_type  = "ClusterIP"
}
