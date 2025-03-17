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

resource "local_file" "ansible_inventory" {
  filename = "../ansible/ansible_inventory.ini"
  content  = <<-EOT
    [app]
    host-app ansible_host=${split("/", var.app_instance_ip)[0]} ansible_user=ubuntu ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

    [bdd]
    host-bdd ansible_host=${split("/", var.bdd_instance_ip)[0]} ansible_user=ubuntu ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
  EOT

  depends_on = [module.app, module.db]
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "cd ../ansible && ansible-playbook -i ansible_inventory.ini main.yml"
  }

  depends_on = [
    local_file.ansible_inventory
  ]
}