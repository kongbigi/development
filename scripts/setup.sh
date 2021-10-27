#!/bin/bash
set -x

# Install necessary dependencies
#sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
#sudo apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates
#sudo add-apt-repository ppa:longsleep/golang-backports -y
#sudo apt -y -qq install golang-go

#sudo apt-get update
#sudo apt -o Dpkg::Options::='--force-confnew' -q --force-yes -y full-upgrade
#sudo apt-get autoremove -q -y
#sudo apt-get autoclean -q -y

#sudo yum install java-1.8.0-openjdk.x86_64
sudo yum -y install /tmp/Nessus-8.12.1-amzn.x86_64.rpm
#/opt/nessus/sbin/nessuscli update nessus-updates-8.9.1.tar.gz
sudo /sbin/service nessusd start
sudo /opt/nessus/sbin/nessuscli fetch --register 8S9T-B5MQ-SMVG-R92C
sudo /opt/nessus/sbin/nessuscli fix --set remote_listen_port=443
sudo /opt/nessus/sbin/nessuscli fix --set xmlrpc_listen_port=443
sudo /opt/nessus/sbin/nessuscli update --all
#sudo systemctl enable nessusd.service
#sudo systemctl start nessusd.service

# Setup sudo to allow no-password sudo for "hashicorp" group and adding "terraform" user
sudo groupadd -r nessus
sudo useradd -m -s /bin/bash penuser1
sudo usermod -a -G nessus penuser1
sudo cp /etc/sudoers /etc/sudoers.orig
echo "penuser1  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/penuser1

# Installing SSH key
sudo mkdir -p /home/penuser1/.ssh
sudo chmod 700 /home/penuser1/.ssh
sudo cp /tmp/tf-packer.pub /home/penuser1/.ssh/authorized_keys
sudo chmod 600 /home/penuser1/.ssh/authorized_keys
sudo chown -R penuser1 /home/penuser1/.ssh
sudo usermod --shell /bin/bash penuser1

# system configuration
sudo timedatectl set-timezone CET
sudo hostnamectl set-hostname prod-nessus.unzer.cloud


# Create GOPATH for Terraform user & download the webapp from github

#sudo -H -i -u penuser1 -- env bash << EOF
#whoami
#echo ~penuser1

#cd /home/penuser1

#export GOROOT=/usr/lib/go
#export GOPATH=/home/terraform/go
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
#go get -d github.com/hashicorp/learn-go-webapp-demo
#EOF
