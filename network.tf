resource "hcloud_network" "network" {
  name     = "kubernetes_network"
  ip_range = "172.16.0.0/12"
}

resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.network.id
  type         = "server"
  network_zone = var.network_zone
  ip_range     = "172.16.0.0/12"
}

resource "hcloud_server_network" "node_network" {
  count      = var.node_count
  server_id  = hcloud_server.nodes[count.index].id
  network_id = hcloud_network.network.id
  ip         = "172.16.0.${count.index + 1}"
}

