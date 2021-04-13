resource "hcloud_server" "nodes" {
  count       = var.node_count
  name        = "cl${var.kubernetes_cluster_name}no${count.index + 1}"
  image       = "ubuntu-20.04"
  server_type = var.node_type
  location    = var.location
  ssh_keys    = var.ssh_key_ids
  user_data   = templatefile("${path.module}/cloud-config.yml")
}
