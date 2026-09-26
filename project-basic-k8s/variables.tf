variable "namespace" {
  description = "Kubernetes namespace for the application"
  type        = string
  default     = "terraform-demo"
}

variable "environment" {
  description = "Application environment"
  type        = string
  default     = "dev"
}

variable "replicas" {
  description = "Number of application replicas"
  type        = number
  default     = 2
}

variable "image" {
  description = "Container image"
  type        = string
  default     = "nginx:latest"
}