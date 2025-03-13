terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.73.0"
    }
  }
}

provider "proxmox" {
  endpoint = local.provider_endpoint
  insecure = true
  username = local.provider_username
  password = local.provider_password
  ssh {
    username = local.provider_ssh_username
    agent = true
  }
}