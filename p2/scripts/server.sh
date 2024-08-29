#!/bin/sh

apt-get update -y
apt-get install net-tools

export K3S_KUBECONFIG_MODE=644
export INSTALL_K3S_EXEC="server --node-ip=$1 --bind-address=$1 --flannel-iface=eth1"

curl -sfL https://get.k3s.io | sh -

kubectl apply -f /vagrant_shared/app1.yaml --validate=warn
kubectl apply -f /vagrant_shared/app2.yaml --validate=warn
kubectl apply -f /vagrant_shared/app3.yaml --validate=warn
kubectl apply -f /vagrant_shared/ingress.yaml --validate=warn
