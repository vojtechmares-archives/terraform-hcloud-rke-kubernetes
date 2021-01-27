# terraform-hcloud-rke-kubernetes
Terraform module for creating and managing Kubernetes clusters with RKE on Hetzner Cloud

<!-- TOC -->

- [What is a Terraform module](#what-is-a-terraform-module)
- [How do you use this module](#how-do-you-use-this-module)
- [Kubernetes cluster provisioning](#kubernetes-cluster-provisioning)

<!-- /TOC -->

## What is a Terraform module

A Terraform module refers to a self-contained package of Terraform configurations that are managed as a group. For more information about modules refer to the Terraform documentation.

## How do you use this module

This module currently supports only Terraform `0.14`.

### Kubernetes cluster provisioning

A Kubernetes cluster can be provisioned by creating a `main.tf` file in an empty directory with the following content, do not forget to configure all the variables - they are all required.

```hcl
module "rke-kubernetes" {
  source  = "vojtechmares/rke-kubernetes/hcloud"
  version = "0.1.0"
  # insert the 12 required variables here
}

output "kubeconfig" {
  value     = module.rke-kubernetes.kube_config_yaml
  sensitive = true
}

output "lbipv4" {
  value = module.rke-kubernetes.load_balancer_ipv4
}
```

Once you have the module configured, you can apply it by running:

```bash
terraform init
terraform apply
```
