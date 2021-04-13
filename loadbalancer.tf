resource "hcloud_load_balancer" "lb" {
  name               = "lb"
  load_balancer_type = var.lb_type
  location           = var.location
}

resource "hcloud_load_balancer_target" "lb_targets" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.lb.id

  count     = var.node_count
  server_id = hcloud_server.nodes[count.index].id

  depends_on = [hcloud_load_balancer.lb, hcloud_server.nodes]
}
