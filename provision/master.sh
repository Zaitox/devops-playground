apk add ansible
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--advertise-address ${MASTER_IP}" sh -s - 

# wait for the node-token file
counter=0
while ! cp /var/lib/rancher/k3s/server/node-token /vagrant/common/.tmp/node-token && (( counter < 10 )); do
  sleep 5
  ((counter++))
done

if [[ $counter -eq 10 ]]; then
  echo "Failed to get Kubernetes token after 10 retries"
  exit 1
fi
