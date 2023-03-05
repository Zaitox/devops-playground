# devops-playground

This can be used with Vagrant to set up a lightweight k3s Kubernetes cluster for testing etc.

Also installs Ansible on the master VM and mounts a hosts file.

Can be configured by changing the Settings in the Vagrantfile and the referenced provision shell scripts.

Run with:
```
vagrant up
```