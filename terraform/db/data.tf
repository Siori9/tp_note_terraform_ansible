data "proxmox_virtual_environment_pool" "operation_pool" {
  pool_id = "cytech"
}

data "local_file" "ssh_public_key" {
  filename = var.ssh_key
}