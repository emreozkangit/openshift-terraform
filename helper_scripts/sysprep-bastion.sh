#!/usr/bin/env bash
sudo yum update -y
sleep 10
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
sleep 10
sudo yum install -y "@Development Tools" python2-pip openssl-devel python-devel gcc libffi-devel git
sleep 10
sudo yum install -y pyOpenSSL python-cryptography python-lxml httpd-tools java-1.8.0-openjdk-headless
sleep 10
sudo git clone https://github.com/berndonline/openshift-ansible
sleep 10
sudo pip install --upgrade pip
sleep 10
sudo pip install 'ansible==2.6.5' passlib jmespath
