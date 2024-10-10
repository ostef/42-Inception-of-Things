#!/bin/bash

sudo k3d cluster create -p "8080:80" p3

sudo kubectl cluster-info

sudo kubectl create namespace dev
sudo kubectl create namespace argocd
sudo kubectl get namespace

# Install ArgoCD
sudo kubectl apply -n argocd -f confs/argocd.yaml
sudo kubectl apply -n argocd -f confs/ingress.yaml
sudo kubectl apply -n argocd -f confs/app.yaml

sudo kubectl get pods -n argocd

sleep 10
sudo kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d > argoCD_password.txt
