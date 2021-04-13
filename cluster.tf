resource "time_sleep" "cluster_wait" {
  depends_on = [hcloud_server.nodes]

  create_duration = "60s"
}

resource "rke_cluster" "cluster" {
  depends_on = [time_sleep.cluster_wait]

  cluster_name = var.kubernetes_cluster_name

  ssh_agent_auth = true

  upgrade_strategy {
    drain                  = var.kubernetes_upgrade_strategy_drain
    max_unavailable_worker = var.kubernetes_upgrade_strategy_max_unavailable_workers
  }

  dynamic "nodes" {
    for_each = hcloud_server.nodes
    content {
      address = nodes.value.ipv4_address
      user    = "root"
      role    = ["controlplane", "worker", "etcd"]
    }
  }

  kubernetes_version = var.kubernetes_version

  network {
    plugin = "canal"
  }

  ingress {
    provider = "none"
  }
}
