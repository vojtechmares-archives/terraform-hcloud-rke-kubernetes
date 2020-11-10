terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">=1.23.0"
    }
    rke = {
      source  = "rancher/rke"
      version = ">=1.1.4"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.6.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">=2.2.0"
    }
  }
  required_version = ">= 0.13"
}
