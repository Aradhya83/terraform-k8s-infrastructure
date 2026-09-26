terraform {
    required_providers{
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "~>2.20"
        }
    }
}

provider "kubernetes" {
    confi_path = "~/.kube/config"
}