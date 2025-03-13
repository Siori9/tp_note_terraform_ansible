module "app" {
  source = "./app"
  instance_name = var.app_instance_name
  instance_memory = var.app_instance_memory
  instance_disk = var.app_instance_disk
  instance_ip = var.app_instance_ip
  instance_vCPU = var.app_instance_vCPU
  instance_os = var.app_instance_os
  ssh_key = var.ssh_key

  depends_on = [module.db]

  providers = {
    proxmox = proxmox
  }
}

module "db" {
  source = "./db"
  instance_name = var.bdd_instance_name
  instance_memory = var.bdd_instance_memory
  instance_disk = var.bdd_instance_disk
  instance_ip = var.bdd_instance_ip
  instance_vCPU = var.bdd_instance_vCPU
  instance_os = var.bdd_instance_os
  ssh_key = var.ssh_key

  providers = {
    proxmox = proxmox
  }
}