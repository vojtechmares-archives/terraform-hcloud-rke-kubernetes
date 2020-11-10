resource "hcloud_server" "nodes" {
  count       = var.node_count
  name        = "node-${count.index + 1}"
  image       = var.node_image
  server_type = var.node_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.rke.name]
  depends_on  = [hcloud_ssh_key.rke]
  user_data   = data.template_file.docker.rendered
}

data "template_file" "docker" {
  template = file("${path.module}/docker-cloud-init.yaml")
}
