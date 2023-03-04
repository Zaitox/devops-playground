Vagrant.configure("2") do |config|
  VAGRANT_EXPERIMENTAL="disks"

  # Define the box and network settings
  config.vm.box = "generic/alpine317"
  #config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.disk :disk, size: "20GB", primary: true


  # Define the number of Kubernetes master nodes to provision
  k8s_master_nodes = 1
  # Define the number of Kubernetes minion nodes to provision
  k8s_minion_nodes = 2
  

  config.vm.provision "shell", path: "provision/common.sh"
  # Provision the Kubernetes master nodes
  (1..k8s_master_nodes).each do |i|
    config.vm.define "k8s-master#{i}" do |master|
      master.vm.hostname = "k8s-master#{i}"
      master.vm.network :private_network, ip: "192.168.33.#{i+10}"
      master.vm.synced_folder "./share/master", "/vagrant", mount_options: ["ro"]
      master.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
      # Define the provisioning script for the master nodes
      master.vm.provision "shell", path: "provision/master.sh"
    end
  end

  

  # Provision the Kubernetes minion nodes
  (1..k8s_minion_nodes).each do |i|
    config.vm.define "k8s-minion#{i}" do |minion|
      minion.vm.hostname = "k8s-minion#{i}"
      minion.vm.network :private_network, ip: "192.168.33.#{i+10+k8s_master_nodes}"
      minion.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
      # Define the provisioning script for the minion nodes
      minion.vm.provision "shell", path: "provision/minion.sh"
    end
  end

end
