Vagrant.configure("2") do |config|
  VAGRANT_EXPERIMENTAL="disks"

  # Define the box and network settings
  config.vm.box = "generic/alpine317"
  config.vm.disk :disk, size: "20GB", primary: true

  # Define the Kubernetes master nodes to provision
  k8s_master_nodes = ["192.168.33.11"]
  # Define the Kubernetes minion nodes to provision
  k8s_minion_nodes = ["192.168.33.12", "192.168.33.13", "192.168.33.14"]
  
  # Baseline provisioning for every VM
  config.vm.provision "shell", path: "provision/common.sh"

  # Provision the Kubernetes master nodes
  k8s_master_nodes.each_with_index do |ip, i|
    config.vm.define "k8s-master#{i+1}" do |master|
      master.vm.hostname = "k8s-master#{i+1}"
      master.vm.network :private_network, ip: ip
      master.vm.synced_folder "./share/master", "/vagrant/master", mount_options: ["ro"]
      master.vm.synced_folder "./share/common", "/vagrant/common"
      master.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.cpus = 2
      end
      # Define the provisioning script for the master nodes
      master.vm.provision "shell", path: "provision/master.sh", env: {
        "MASTER_IP" => k8s_master_nodes[i]
      }
    end
  end

  # Provision the Kubernetes minion nodes
  k8s_minion_nodes.each_with_index do |ip, i|
    config.vm.define "k8s-minion#{i+1}" do |minion|
      minion.vm.hostname = "k8s-minion#{i+1}"
      minion.vm.network :private_network, ip: ip
      minion.vm.synced_folder "./share/common", "/vagrant/common"
      minion.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
      # Define the provisioning script for the minion nodes
      minion.vm.provision "shell", path: "provision/minion.sh", env: {
        "MASTER_IP" => k8s_master_nodes[0]
      }
    end
  end
end
