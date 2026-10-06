Terraform-based Kubernetes deployment that provisions a Namespace, ConfigMap, Secret, Deployment and Service as code.

## What this demonstrates
- Infrastructure as Code with Terraform
- Core Kubernetes objects: Namespace, ConfigMap, Secret, Deployment, Service
- Managing application configuration and secrets separately from the container image

## Repository structure
```
terraform-k8s-infrastructure/
├── project-basic-k8s/   # Terraform configuration for the Kubernetes resources
└── README.md
```

## Resources created
| Resource | Purpose |
|---|---|
| Namespace | Isolates the application's resources |
| ConfigMap | Non-sensitive application configuration |
| Secret | Sensitive values (e.g. credentials) |
| Deployment | Runs the application pods |
| Service | Exposes the application inside the cluster |

## Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/) (local Kubernetes cluster) and `kubectl`
## Usage
```bash
cd project-basic-k8s
terraform init
terraform plan
terraform apply
```

Verify the deployment:
```bash
kubectl get all -n [NAMESPACE NAME]
```

Clean up:
```bash
terraform destroy
```

