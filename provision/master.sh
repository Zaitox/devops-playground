echo "node echo ${ETH1_IP}"
apk update
apk add ansible
curl -sfL https://get.k3s.io | sh - --advertise-address 192.168.33.11