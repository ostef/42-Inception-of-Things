#!/bin/sh

apt-get update -y
apt-get install net-tools

export K3S_TOKEN_FILE="/vagrant_shared/token"
export K3S_URL="https://$1:6443"
export INSTALL_K3S_EXEC="--flannel-iface=eth1"

curl -sfL https://get.k3s.io | sh -
