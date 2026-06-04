output "vm1_ip" {
  value = local.vm1_ip_clean
}

output "vm2_ip" {
  value = local.vm2_ip_clean
}

output "nginx_url" {
  value = "http://${local.vm1_ip_clean}:8888"
}

output "grafana_url" {
  value = "http://${local.vm2_ip_clean}:3000"
}

output "prometheus_url" {
  value = "http://${local.vm2_ip_clean}:9090"
}

output "vm_credentials" {
  value = "Логін для VM: falcon | Пароль: falcon123!"
}

output "grafana_credentials" {
  value = "Grafana: http://${local.vm2_ip_clean}:3000 | Логін: admin | Пароль: admin"
}
