# Метод автоматизованого розгортання IT-інфраструктури з використанням технологій IaC

Дипломна робота | Terraform + Ansible + Proxmox + Jenkins

---

## Опис

Повністю автоматизоване розгортання двох віртуальних машин на базі Ubuntu 22.04 через Terraform з подальшим налаштуванням через Ansible.

Одна команда terraform apply - і вся інфраструктура готова за 10-15 хвилин.

---

## Архітектура

    Proxmox VE
    VM1 - Командний сервер
        Nginx (порт 8888)
        Fail2ban
        Node Exporter (порт 9101)

    VM2 - Сервер моніторингу
        Prometheus (порт 9090)
        Grafana (порт 3000)

---

## Швидкий старт

Крок 1. Встановити залежності

    sudo apt install git ansible -y
    wget https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
    unzip terraform_1.5.7_linux_amd64.zip && sudo mv terraform /usr/local/bin/

Крок 2. Клонувати репозиторій

    git clone https://github.com/falcon673/iac-diploma.git
    cd iac-diploma/terraform

Крок 3. Налаштувати Proxmox

    cp terraform.tfvars.example terraform.tfvars
    nano terraform.tfvars

Крок 4. Розгорнути інфраструктуру

    terraform init && terraform apply

Крок 5. Результат після розгортання

    grafana_url         = "http://VM2_IP:3000"
    nginx_url           = "http://VM1_IP:8888"
    prometheus_url      = "http://VM2_IP:9090"
    vm_credentials      = "Логін: falcon | Пароль: falcon123!"
    grafana_credentials = "Логін: admin | Пароль: admin"

---

## Структура проекту

    iac-diploma/
    terraform/
        main.tf
        variables.tf
        outputs.tf
        providers.tf
        free_ips.tf
        get_free_resources.sh
        terraform.tfvars.example
    ansible/
        playbooks/
            vm1_playbook.yml
            vm2_playbook.yml
        roles/
            common/
            nginx/
            fail2ban/
            node_exporter/
            prometheus/
            grafana/

---

## Технології

Terraform      - Розгортання VM на Proxmox
Ansible        - Налаштування сервісів
Proxmox VE     - Платформа віртуалізації
Prometheus     - Збір метрик
Grafana        - Візуалізація метрик
Nginx          - Веб-сервер
Fail2ban       - Захист від brute-force
Jenkins        - CI/CD автоматизація

---

## Автор

Місяць Анна | Дипломна робота 2026
