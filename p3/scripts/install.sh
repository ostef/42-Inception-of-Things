#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y net-tools

if [[ -z $(which docker) ]];
then
    echo Installing Docker
    curl -sfL https://get.docker.com | sh -
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
else
    echo Found Docker
fi

if [[ -z $(which kubectl) ]];
then
    echo Installing K8S

    export K8S_RELEASE=$(curl -L -s https://dl.k8s.io/release/stable.txt)

    sudo curl -LO "https://dl.k8s.io/release/$K8S_RELEASE/bin/linux/amd64/kubectl"
    sudo mv ./kubectl /usr/local/bin
    sudo chmod +x /usr/local/bin/kubectl
else
    echo Found K8S
fi

if [[ -z $(which k3d) ]];
then
    echo Installing K3D

    curl -sfL https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
else
    echo Found K3D
fi
