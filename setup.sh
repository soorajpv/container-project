#!/bin/bash

terraform apply -input=false
terraform output bastion.ip | tr ',' ' ' >/home/ubuntu/myHosts
sleep 20
ansible-playbook python.yaml --private-key keys
ansible-playbook docker.yaml --private-key keys
ansible-playbook container.yaml --private-key keys
