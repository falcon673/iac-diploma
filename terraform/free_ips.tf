data "external" "resources" {
  program = ["bash", "${path.module}/get_free_resources.sh"]
}

locals {
  vm1_ip_auto  = data.external.resources.result["vm1_ip"]
  vm2_ip_auto  = data.external.resources.result["vm2_ip"]
  vm1_id_auto  = tonumber(data.external.resources.result["vm1_id"])
  vm2_id_auto  = tonumber(data.external.resources.result["vm2_id"])
  vm1_name_auto = data.external.resources.result["vm1_name"]
  vm2_name_auto = data.external.resources.result["vm2_name"]
  vm1_ip_clean = split("/", local.vm1_ip_auto)[0]
  vm2_ip_clean = split("/", local.vm2_ip_auto)[0]
  ansible_dir  = "${path.module}/../ansible"
}
