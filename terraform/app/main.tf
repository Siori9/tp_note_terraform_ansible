resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = var.instance_name
  node_name = local.node_name
  pool_id   = data.proxmox_virtual_environment_pool.operation_pool.pool_id
  memory {
    dedicated = var.instance_memory
  }
  network_device {
    bridge = local.bridge
  }
  stop_on_destroy = true

  tags = [var.instance_os]

  cpu {
    cores = var.instance_vCPU
  }

  agent {
    enabled = true
  }

  disk {
    datastore_id = local.disk_datastore_id
    file_id = local.disk_file_id
    interface = local.disk_interface
    iothread = true
    discard = "on"
    size = var.instance_disk
  }

  initialization {
    datastore_id = local.disk_datastore_id
    ip_config {
      ipv4 {
        address = var.instance_ip
        gateway = local.ip_gateway
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id

    user_account {
      username = "ubuntu"
      keys = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = local.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: test-ubuntu
    users:
      - default
      - name: ubuntu
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools
        - timedatectl set-timezone America/Toronto
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config-cytech-7-app.yaml"
  }
}