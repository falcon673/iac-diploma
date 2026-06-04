terraform {
  required_version = ">= 1.3.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.46"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  username  = var.proxmox_user
  password  = var.proxmox_password
  insecure  = true
}
