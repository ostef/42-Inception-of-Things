#!/bin/bash

sudo rm ./argocd_password.txt
sudo rm ./gitlab_password.txt

# sudo kubectl delete namespace gitlab
# sudo kubectl delete namespace dev
# sudo kubectl delete namespace argocd

sudo helm uninstall gitlab
sudo k3d cluster delete -a
sudo docker system prune -af --volumes
