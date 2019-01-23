#!/usr/bin/env bash
sudo subscription-manager register --username username --password password --auto-attach --force
sleep 15
sudo yum-config-manager --disable \*
sleep 15
sudo subscription-manager repos --enable="rhel-7-server-rpms" --enable="rhel-7-server-extras-rpms" --enable="rhel-7-server-ose-3.9-rpms" --enable="rhel-7-fast-datapath-rpms" --enable="rhel-7-server-ansible-2.4-rpms"
sleep 15
sudo subscription-manager refresh
sleep 15
sudo yum install -y wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct
sleep 15
sudo yum update -y
sleep 15
sudo yum install -y docker NetworkManager
sleep 15
sudo bash -c 'cat <<EOF > /etc/sysconfig/docker-storage-setup
DEVS=/dev/xvdb
VG=docker-vg
EOF'
sleep 15
sudo docker-storage-setup
sleep 15
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhs1Yh0+pjqo8P1cnXsRdRV+y0s2+7jc0xKFGOavOe7pBMf7AdvM/EW0PVLzjzU/Ua261z9+LRyWhzWbGsPPrdOg8eQWb25ghyMSnLYmYPASsCtfuLgHaR4BbnPUlqd4MH/YEJDsPMxyzmTa9enqb+QgxOSPTFCCnVeWIzjFfOAFI08eKf0itTnhV/CNvgFQTs2s/MVkZlR1mqvUobXJPmMMp1+n2pSMIVcPI507IH7XKzqfLioIxDLa22YrKxVLA/UzoofI01KJyGfl846uReJVskupRa2/e4sCjl3lo7BulbqdYISi4NIqCIWLNUEibFgA/oD1t3f0CbR6KIRlzh openshift" > /root/.ssh/authorized_keys
sleep 5
sudo systemctl stop docker
sleep 15
sudo systemctl enable docker
sleep 15
sudo rm -rf /var/lib/docker/*
sleep 15
sudo systemctl restart docker
sleep 15
sudo reboot
