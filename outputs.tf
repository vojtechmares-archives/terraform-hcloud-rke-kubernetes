output "load_balancer_ipv4" {
  value       = hcloud_load_balancer.lb.ipv4
  description = "Public IPv4 of a load balancer"
}

output "kube_config_yaml" {
  value       = rke_cluster.cluster.kube_config_yaml
  sensitive   = true
  description = "Kubeconfig for a cluster (in an YAML format)"
}
