variable "instance_memory" {
  type = number
  default = 2048
}

variable "instance_os" {
  type = string
  default = "ubuntu_vm"
}

variable "instance_name" {
  type = string
  default = "my_instance"
}

variable "instance_disk" {
  type = number
  default = 10
}

variable "instance_ip" {
  type = string
}

variable "instance_vCPU" {
  type = number
  default = 1
}

variable "ssh_key" {
  type = string
}