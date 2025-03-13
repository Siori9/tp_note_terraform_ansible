locals {
  node_name = "mgmt"
  bridge = "vmbr0"
  disk_datastore_id = "raid-ssd"
  disk_file_id = "isos:iso/jammy-server-cloudimg-amd64.img"
  disk_interface = "virtio0"
  ip_gateway = "192.168.100.1"
}

