variable "proxmox_api_url" {
  description = "URL Proxmox API"
  type        = string
}

variable "proxmox_user" {
  description = "Користувач Proxmox"
  type        = string
  default     = "root@pam"
}

variable "proxmox_password" {
  description = "Пароль Proxmox"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Назва вузла Proxmox"
  type        = string
  default     = "pve"
}

variable "template_name" {
  description = "Назва шаблону Ubuntu 22.04"
  type        = string
  default     = "ubuntu-22.04-template"
}

variable "vm1_ip" {
  type    = string
  default = "192.168.177.18/24"
}

variable "vm2_ip" {
  type    = string
  default = "192.168.177.22/24"
}

variable "gateway" {
  type    = string
  default = "192.168.177.1"
}

variable "ssh_private_key_path" {
  type    = string
  default = "~/.ssh/id_rsa"
}

variable "vm1_user" {
  type    = string
  default = "falcon"
}

variable "vm2_user" {
  type    = string
  default = "falcon2"
}

variable "svc_user" {
  type    = string
  default = "svcuser"
}

variable "ansible_playbook_vm1" {
  type    = string
  default = "~/diploma/ansible/playbooks/vm1_playbook.yml"
}

variable "ansible_playbook_vm2" {
  type    = string
  default = "~/diploma/ansible/playbooks/vm2_playbook.yml"
}
