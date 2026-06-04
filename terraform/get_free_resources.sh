#!/bin/bash
PROXMOX_URL="https://192.168.177.3:8006"
USER="MisyatsAnna@pve"
PASS="Qwerty123@"
SUBNET="192.168.177"

# Отримуємо токен
TOKEN=$(curl -sk -d "username=$USER&password=$PASS" $PROXMOX_URL/api2/json/access/ticket | python3 -c "import sys,json; print(json.load(sys.stdin)['data']['ticket'])")

# Отримуємо список зайнятих VM ID
USED_IDS=$(curl -sk -b "PVEAuthCookie=$TOKEN" $PROXMOX_URL/api2/json/nodes/pvecadet/qemu | python3 -c "import sys,json; [print(v['vmid']) for v in json.load(sys.stdin)['data']]")

# Знаходимо 2 вільних ID від 200 до 900
count=0
VM1_ID=""
VM2_ID=""
for i in $(seq 500 900); do
  if ! echo "$USED_IDS" | grep -q "^$i$"; then
    if [ -z "$VM1_ID" ]; then
      VM1_ID=$i
    elif [ -z "$VM2_ID" ]; then
      VM2_ID=$i
      break
    fi
  fi
done

# Знаходимо 2 вільних IP
count=0
VM1_IP=""
VM2_IP=""
for i in $(seq 50 200); do
  if ! ping -c1 -W0.2 $SUBNET.$i > /dev/null 2>&1; then
    if [ -z "$VM1_IP" ]; then
      VM1_IP="$SUBNET.$i"
    elif [ -z "$VM2_IP" ]; then
      VM2_IP="$SUBNET.$i"
      break
    fi
  fi
done

# Генеруємо унікальні назви
SUFFIX=$(date +%s | tail -c 5)
VM1_NAME="iac-vm1-$SUFFIX"
VM2_NAME="iac-vm2-$SUFFIX"

# Виводимо JSON для Terraform
python3 -c "
import json
print(json.dumps({
  'vm1_id': str($VM1_ID),
  'vm2_id': str($VM2_ID),
  'vm1_ip': '${VM1_IP}/24',
  'vm2_ip': '${VM2_IP}/24',
  'vm1_name': '$VM1_NAME',
  'vm2_name': '$VM2_NAME'
}))
"
