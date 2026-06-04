
# VM1 — Командний сервер
resource "proxmox_virtual_environment_vm" "vm1" {
  name      = local.vm1_name_auto
  node_name = var.proxmox_node
  vm_id     = local.vm1_id_auto
  bios      = "ovmf"
  machine   = "q35"
  agent {
  enabled = false
}
  clone {
    vm_id = 9000
    full  = true
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    datastore_id = "vms"
    interface    = "scsi0"
    size         = 20
  }

  initialization {
    datastore_id = "vms" 
    ip_config {
      ipv4 {
        address = local.vm1_ip_auto
        gateway = "192.168.177.254"
      }
    }
    user_account {
      username = var.vm1_user
      password = "falcon123!"
      keys     = [file(pathexpand("~/.ssh/id_rsa.pub"))]
    }
  }

  provisioner "remote-exec" {
    inline = ["echo 'VM1 SSH ready'"]
    connection {
      type        = "ssh"
      host        = local.vm1_ip_clean
      user        = var.vm1_user
      private_key = file(pathexpand(var.ssh_private_key_path))
      timeout     = "10m"
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook \
        -i ${local.vm1_ip_clean}, \
        ${local.ansible_dir}/playbooks/vm1_playbook.yml \
        --private-key ${pathexpand(var.ssh_private_key_path)} \
        --extra-vars "svc_user=${var.svc_user}" \
        -u ${var.vm1_user} \
        --ssh-extra-args='-o StrictHostKeyChecking=no'
    EOT
  }
}

# VM2 — Сервер моніторингу
resource "proxmox_virtual_environment_vm" "vm2" {
  name      = local.vm2_name_auto
  node_name = var.proxmox_node
  vm_id     = local.vm2_id_auto
  bios      = "ovmf"
  machine   = "q35"  
  agent {
  enabled = false
}
  clone {
    vm_id = 9000
    full  = true
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    datastore_id = "vms"
    interface    = "scsi0"
    size         = 20
  }

  initialization {
    datastore_id = "vms"
    ip_config {
      ipv4 {
        address = local.vm2_ip_auto
        gateway = "192.168.177.254"
      }
    }
    user_account {
      username = var.vm2_user
      password = "falcon123!"
      keys     = [file(pathexpand("~/.ssh/id_rsa.pub"))]
    }
  }

  depends_on = [proxmox_virtual_environment_vm.vm1]

  provisioner "remote-exec" {
    inline = ["echo 'VM2 SSH ready'"]
    connection {
      type        = "ssh"
      host        = local.vm2_ip_clean
      user        = var.vm2_user
      private_key = file(pathexpand(var.ssh_private_key_path))
      timeout     = "10m"
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook \
        -i ${local.vm2_ip_clean}, \
        ${local.ansible_dir}/playbooks/vm2_playbook.yml \
        --private-key ${pathexpand(var.ssh_private_key_path)} \
        --extra-vars "svc_user=${var.svc_user} vm1_ip=${local.vm1_ip_clean}" \
        -u ${var.vm2_user} \
        --ssh-extra-args='-o StrictHostKeyChecking=no'
    EOT
  }
}
