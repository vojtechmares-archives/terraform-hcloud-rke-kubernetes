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
      ssh_key = var.ssh_private_key
      port    = 22
    }
  }

  kubernetes_version = var.kubernetes_version

  services {
    kube_api {
      service_cluster_ip_range = "10.43.0.0/16"
    }

    kube_controller {
      cluster_cidr             = "10.42.0.0/16"
      service_cluster_ip_range = "10.43.0.0/16"
    }

    kubelet {
      cluster_domain               = "cluster.local"
      cluster_dns_server           = "10.43.0.10"
      fail_swap_on                 = false
      generate_serving_certificate = false
    }

    etcd {}

    scheduler {}

    kubeproxy {}
  }

  authentication {
    strategy = "x509"
  }

  authorization {
    mode = "rbac"
  }

  network {
    plugin = "canal"
  }

  ingress {
    provider = "none"
  }

  addon_job_timeout = 10
}
