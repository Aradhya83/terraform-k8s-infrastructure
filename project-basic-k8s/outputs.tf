output "namespace" {
  description = "Kubernetes namespace"
  value       = kubernetes_namespace.app.metadata[0].name
}

output "service_name" {
  description = "Kubernetes service name"
  value       = kubernetes_service.app.metadata[0].name
}

output "service_port" {
  description = "Kubernetes service port"
  value       = kubernetes_service.app.spec[0].port[0].port
}