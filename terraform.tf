variable "ssh_key_ids" {
  type = set(string)
}

variable "location" {
  type        = string
  description = "Hetzner Cloud datacenter to deploy servers and load balancer to"
}

variable "node_count" {
  type        = number
  description = "Number of servers (nodes) for Kubernetes cluster"
}

variable "node_type" {
  type        = string
  description = "Type of server (size e.g. `cpx31`)"
}

variable "load_balancer_type" {
  type        = string
  description = "Type of load balancer (e.g. `lb11`)"
}

variable "kubernetes_version" {
  type        = string
  description = "Version of Kubernetes cluster created by RKE (e.g `v1.20.5-rancher1-1`)"
}

variable "kubernetes_cluster_name" {
  type        = string
  description = "Name of Kubernetes cluster"
}

variable "kubernetes_upgrade_strategy_drain" {
  type        = bool
  description = "Kubernetes should drain node on upgrade"
}

variable "kubernetes_upgrade_strategy_max_unavailable_workers" {
  type        = string
  description = "Maximum of Kubernetes unavailable workers"
}

variable "network_zone" {
  type = string
}

output "load_balancer_ipv4" {
  value       = hcloud_load_balancer.lb.ipv4
  description = "Public IPv4 of a load balancer"
}

output "kube_config_yaml" {
  value       = rke_cluster.cluster.kube_config_yaml
  sensitive   = true
  description = "Kubeconfig for a cluster (in an YAML format)"
}
