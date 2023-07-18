variable "app_name" {
  description = "Name of the app"
}

variable "container_image" {
  description = "Container Image"
}

variable "container_port" {
  description = "Container exposed port"
}

variable "container_type" {
  description = "Container deployment type"
}

variable "loadbalancer_public_ip" {
  description = "LoadBalancer public IP"
}
