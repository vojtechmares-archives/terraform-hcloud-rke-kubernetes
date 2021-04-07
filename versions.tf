terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">=1.26.0"
    }
    rke = {
      source  = "rancher/rke"
      version = ">=1.2.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.7.0"
    }
  }
  required_version = ">= 0.14"
}
