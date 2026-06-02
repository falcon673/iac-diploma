# Метод автоматизованого розгортання ІТ-інфраструктури з використанням технологій IaC

## Опис
Дипломна робота з автоматизованого розгортання двох віртуальних машин через Terraform + Ansible.

## Архітектура
VM1 (Командний сервер)
- Nginx (порт 8888)
- Fail2ban
- Node Exporter (порт 9101)

VM2 (Сервер моніторингу)
- Prometheus (порт 9090)
- Grafana (порт 3000)

## Вимоги
- Terraform >= 1.3
- Ansible >= 2.10
- SSH доступ до VM1 та VM2

## Швидкий старт
git clone https://github.com/falcon673/iac-diploma.git
cd iac-diploma/terraform
terraform init
terraform apply

## Результат після розгортання
| Сервіс | URL |
|--------|-----|
| Nginx VM1 | http://VM1_IP:8888 |
| Prometheus | http://VM2_IP:9090 |
| Grafana | http://VM2_IP:3000 |

## Технології
- Terraform
- Ansible
- Prometheus
- Grafana
- Nginx
- Fail2ban
