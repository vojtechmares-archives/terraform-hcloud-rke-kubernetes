resource "time_sleep" "cluster_wait" {
  depends_on = [hcloud_server.nodes]

  create_duration = "60s"
}

resource "rke_cluster" "cluster" {
  depends_on = [time_sleep.cluster_wait]

  cluster_name = var.kubernetes_cluster_name

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

  system_images {
    etcd                        = "rancher/coreos-etcd:v3.4.3-rancher1"
    alpine                      = "rancher/rke-tools:v0.1.56"
    nginx_proxy                 = "rancher/rke-tools:v0.1.56"
    cert_downloader             = "rancher/rke-tools:v0.1.56"
    kubernetes_services_sidecar = "rancher/rke-tools:v0.1.56"
    kube_dns                    = "rancher/k8s-dns-kube-dns:1.15.0"
    dnsmasq                     = "rancher/k8s-dns-dnsmasq-nanny:1.15.0"
    kube_dns_sidecar            = "rancher/k8s-dns-sidecar:1.15.0"
    kube_dns_autoscaler         = "rancher/cluster-proportional-autoscaler:1.7.1"
    coredns                     = "rancher/coredns-coredns:1.6.5"
    coredns_autoscaler          = "rancher/cluster-proportional-autoscaler:1.7.1"
    nodelocal                   = "rancher/k8s-dns-node-cache:1.15.7"
    kubernetes                  = "rancher/hyperkube:v1.17.4-rancher1"
    flannel                     = "rancher/coreos-flannel:v0.11.0-rancher1"
    flannel_cni                 = "rancher/flannel-cni:v0.3.0-rancher5"
    calico_node                 = "rancher/calico-node:v3.13.0"
    calico_cni                  = "rancher/calico-cni:v3.13.0"
    calico_controllers          = "rancher/calico-kube-controllers:v3.13.0"
    calico_ctl                  = "rancher/calico-ctl:v2.0.0"
    calico_flex_vol             = "rancher/calico-pod2daemon-flexvol:v3.13.0"
    canal_node                  = "rancher/calico-node:v3.13.0"
    canal_cni                   = "rancher/calico-cni:v3.13.0"
    canal_flannel               = "rancher/coreos-flannel:v0.11.0"
    canal_flex_vol              = "rancher/calico-pod2daemon-flexvol:v3.13.0"
    weave_node                  = "weaveworks/weave-kube:2.5.2"
    weave_cni                   = "weaveworks/weave-npc:2.5.2"
    pod_infra_container         = "rancher/pause:3.1"
    ingress                     = "rancher/nginx-ingress-controller:nginx-0.25.1-rancher1"
    ingress_backend             = "rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1"
    metrics_server              = "rancher/metrics-server:v0.3.6"
    windows_pod_infra_container = "rancher/kubelet-pause:v0.1.3"
  }

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
