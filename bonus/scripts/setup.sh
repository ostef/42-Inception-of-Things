#!/bin/bash

sudo k3d cluster create -p "8080:80" bonus

sudo kubectl cluster-info

sudo kubectl create namespace dev
sudo kubectl create namespace argocd
sudo kubectl create namespace gitlab
sudo kubectl get namespace

# Install ArgoCD
sudo kubectl apply -n argocd -f confs/argocd.yaml
sudo kubectl apply -n argocd -f confs/app.yaml
sudo kubectl apply -f confs/ingress.yaml

# Install GitLab
sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update
sudo helm upgrade --install gitlab gitlab/gitlab \
  --namespace gitlab \
  -f ./confs/gitlab.yaml

sudo kubectl get pods -n argocd
sudo kubectl get pods -n dev
sudo kubectl get pods -n gitlab
