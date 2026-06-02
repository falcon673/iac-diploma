locals {
  vm1_ip = "192.168.177.18"
  vm2_ip = "192.168.177.22"
}

resource "null_resource" "vm1" {
  provisioner "remote-exec" {
    inline = ["echo 'VM1 SSH ready'"]
    connection {
      type        = "ssh"
      host        = local.vm1_ip
      user        = var.vm1_user
      private_key = file(pathexpand(var.ssh_private_key_path))
      timeout     = "5m"
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook \
        -i ${local.vm1_ip}, \
        ~/diploma/ansible/playbooks/vm1_playbook.yml \
        --private-key ${pathexpand(var.ssh_private_key_path)} \
        --extra-vars "svc_user=${var.svc_user}" \
        -u ${var.vm1_user} \
        --ssh-extra-args='-o StrictHostKeyChecking=no'
    EOT
  }
}

resource "null_resource" "vm2" {
  depends_on = [null_resource.vm1]

  provisioner "remote-exec" {
    inline = ["echo 'VM2 SSH ready'"]
    connection {
      type        = "ssh"
      host        = local.vm2_ip
      user        = var.vm2_user
      private_key = file(pathexpand(var.ssh_private_key_path))
      timeout     = "5m"
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook \
        -i ${local.vm2_ip}, \
        ~/diploma/ansible/playbooks/vm2_playbook.yml \
        --private-key ${pathexpand(var.ssh_private_key_path)} \
        --extra-vars "svc_user=${var.svc_user} vm1_ip=${local.vm1_ip}" \
        -u ${var.vm2_user} \
        --ssh-extra-args='-o StrictHostKeyChecking=no'
    EOT
  }
}  
