#!/usr/bin/env bash
sudo subscription-manager register --username username --password password --auto-attach --force

sudo yum-config-manager --disable \*
sleep 15
sudo subscription-manager refresh
sudo subscription-manager repos --enable="rhel-7-server-rpms" --enable="rhel-7-server-extras-rpms" --enable="rhel-7-server-ose-3.9-rpms" --enable="rhel-7-fast-datapath-rpms" --enable="rhel-7-server-ansible-2.4-rpms"
sleep 15
sudo subscription-manager refresh
sleep 15
sudo yum install -y  python2-pip openssl-devel python-devel gcc libffi-devel
sleep 15
sudo yum install -y wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct
sleep 15
sudo yum update -y
sleep 15
sudo yum install -y ansible
sleep 15
sudo yum install -y openshift-ansible
sleep 15
sudo reboot