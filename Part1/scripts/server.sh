#!/bin/sh

apt-get update -y
apt-get install net-tools

export INSTALL_K3S_EXEC="server --node-ip=$1 --bind-address=$1 --flannel-iface=eth1"

curl -sfL https://get.k3s.io | sh -

cp /var/lib/rancher/k3s/server/node-token /vagrant_shared/token
