// Provider variables
variable "hcloud_token" {
  type        = string
  description = "API Token for Hetzner Cloud"
}

// Module specific variables
variable "ssh_public_key" {
  type        = string
  description = "SSH Public key uploaded to nodes for remote access and RKE"
}
variable "ssh_private_key" {
  type        = string
  description = "SSH Private key (pair with `ssh_public_key`) for RKE to access nodes to install Kubernetes components"
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
variable "node_image" {
  type        = string
  description = "Server image to choose base operating system (e.g. `ubuntu-20.04`)"
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
