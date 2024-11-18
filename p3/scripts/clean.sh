#!/bin/bash

sudo rm ./argocd_password.txt

sudo kubectl delete deployments -n dev --all
sudo kubectl delete services -n dev --all
sudo kubectl delete pods -n dev --all

sudo kubectl delete deployments -n argocd --all
sudo kubectl delete services -n argocd --all
sudo kubectl delete pods -n argocd --all

sudo k3d cluster delete p3
