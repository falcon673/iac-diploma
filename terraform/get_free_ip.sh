#!/bin/bash
SUBNET="192.168.177"
count=0
VM1_IP=""
VM2_IP=""
for i in $(seq 50 200); do
  if ! ping -c1 -W1 $SUBNET.$i > /dev/null 2>&1; then
    if [ -z "$VM1_IP" ]; then
      VM1_IP="$SUBNET.$i"
    elif [ -z "$VM2_IP" ]; then
      VM2_IP="$SUBNET.$i"
      break
    fi
  fi
done
# Записуємо в файл який читає Terraform
cat > /tmp/free_ips.json << JSONEOF
{
  "vm1_ip": "${VM1_IP}/24",
  "vm2_ip": "${VM2_IP}/24"
}
JSONEOF
echo "Знайдені вільні IP: VM1=$VM1_IP VM2=$VM2_IP"
