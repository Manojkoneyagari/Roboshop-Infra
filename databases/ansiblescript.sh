#!/bin/bash

component=$1
apt update -y
apt install ansible -y


cd /home/ubuntu
git clone https://github.com/Manojkoneyagari/Roboshop-Ansible-V3.git
cd Roboshop-Ansible-V3
git pull

ansible-playbook main.yaml -e "component=$component"