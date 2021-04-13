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

For more information, have a look at [examples](https://github.com/vojtechmares/terraform-hcloud-rke-kubernetes/blob/master/examples).

### Kubernetes cluster provisioning

#### SSH Keys

You need to provide IDs of Terraform resources you wish to add to your servers. Also, one of the keys is expected to be loaded in your SSH agent in order to create a cluster (to access the nodes and install Kubernetes components on them).

#### OS

This module since version `0.2` is using Ubuntu 20.04 without the ability to change the OS since it would require different cloud-config per OS.

Ubuntu is set up and configured to install Docker before creating the cluster, since RKE does not install Docker automatically.

**NOTE**: `ufw` is disabled.

#### Kubernetes version

Version is specified in module's variable `kubernetes_version`, version string looks like following: `v1.20.5-rancher1-1`.

The Rancher distribution of Kubernetes is CNCF certified distribution of Kubernetes. No drawbacks.

To get the list of supported Kubernetes version by RKE, run RKE locally on your computer

```bash
rke config --list-version --all
```
