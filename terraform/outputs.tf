output "vm1_ip" {
  value = split("/", var.vm1_ip)[0]
}

output "vm2_ip" {
  value = split("/", var.vm2_ip)[0]
}

output "nginx_url" {
  value = "http://${split("/", var.vm1_ip)[0]}"
}

output "grafana_url" {
  value = "http://${split("/", var.vm2_ip)[0]}:3000"
}

output "prometheus_url" {
  value = "http://${split("/", var.vm2_ip)[0]}:9090"
}
