provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "rke" {
  name       = "rke"
  public_key = var.ssh_public_key
}
