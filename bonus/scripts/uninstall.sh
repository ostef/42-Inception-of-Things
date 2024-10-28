#!/bin/bash

./clean.sh

# Uninstall K3D

if [[ -n $(which k3d) ]];
then
    sudo rm $(which k3d)
    sudo rm -rf ~/.k3d
fi

# Uninstall Docker

sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin
sudo apt-get autoremove --purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin
sudo apt-get clean -y

sudo rm -rf /var/lib/docker

# Uninstall kubectl

if [[ -n $(which kubectl) ]];
then
    sudo rm $(which kubectl)
    sudo rm -rf ~/.kube
fi
