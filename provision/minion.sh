NODE_TOKEN=$(cat /vagrant/common/.tmp/node-token)
curl -sfL https://get.k3s.io | K3S_URL=https://${MASTER_IP}:6443 K3S_TOKEN=${NODE_TOKEN} sh -