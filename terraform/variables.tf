variable "app_instance_memory" {
  type = number
  default = 2048
}

variable "app_instance_os" {
  type = string
  default = "ubuntu_vm"
}

variable "app_instance_name" {
  type = string
  default = "my_instance"
}

variable "app_instance_disk" {
  type = number
  default = 10
}

variable "app_instance_ip" {
  type = string
}

variable "app_instance_vCPU" {
  type = number
  default = 1
}

variable "bdd_instance_memory" {
  type = number
  default = 2048
}

variable "bdd_instance_os" {
  type = string
  default = "ubuntu_vm"
}

variable "bdd_instance_name" {
  type = string
  default = "my_instance"
}

variable "bdd_instance_disk" {
  type = number
  default = 10
}

variable "bdd_instance_ip" {
  type = string
}

variable "bdd_instance_vCPU" {
  type = number
  default = 1
}

variable "ssh_key" {
  type = string
}