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
  default     = "pvecadet"
}

variable "template_name" {
  description = "Назва шаблону Ubuntu 22.04"
  type        = string
  default     = "ubuntu22.04"
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
  default = "192.168.177.254"
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

variable "vm1_name" {
  description = "Назва VM1 у Proxmox"
  type        = string
  default     = "auto"
}

variable "vm2_name" {
  description = "Назва VM2 у Proxmox"
  type        = string
  default     = "auto"
}

variable "vm1_vmid" {
  description = "ID VM1 у Proxmox (унікальний)"
  type        = number
  default     = 0
}

variable "vm2_vmid" {
  description = "ID VM2 у Proxmox (унікальний)"
  type        = number
  default     = 0
}

variable "vm_password" {
  description = "Пароль для нових VM"
  type        = string
  default     = "falcon123"
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH публічний ключ для VM"
  type        = string
  default     = ""
}
