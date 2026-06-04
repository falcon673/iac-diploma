#!/bin/bash
SUBNET="192.168.177"
count=0
for i in $(seq 100 200); do
  if ! ping -c1 -W1 $SUBNET.$i > /dev/null 2>&1; then
    if [ $count -eq 0 ]; then
      VM1_IP="$SUBNET.$i"
      count=1
    elif [ $count -eq 1 ]; then
      VM2_IP="$SUBNET.$i"
      break
    fi
  fi
done
echo "VM1_IP=$VM1_IP"
echo "VM2_IP=$VM2_IP"
# Оновлюємо tfvars
sed -i "s|vm1_ip.*|vm1_ip = \"$VM1_IP/24\"|" terraform.tfvars
sed -i "s|vm2_ip.*|vm2_ip = \"$VM2_IP/24\"|" terraform.tfvars
echo "Вільні IP: VM1=$VM1_IP VM2=$VM2_IP"
