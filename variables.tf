// Provider variables
variable "hcloud_token" {
  type = string
}

// Module specific variables
variable "ssh_public_key" {
  type = string
}
variable "ssh_private_key" {
  type = string
}
variable "location" {
  type = string
}
variable "node_count" {
  type = number
}
variable "node_type" {
  type = string
}
variable "node_image" {
  type = string
}
variable "load_balancer_type" {
  type = string
}
variable "kubernetes_version" {
  type = string
}
variable "kubernetes_cluster_name" {
  type = string
}
