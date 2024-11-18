#!/bin/bash

sudo k3d cluster create p3

sudo kubectl cluster-info

sudo kubectl create namespace dev
sudo kubectl create namespace argocd

# Install ArgoCD
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl apply -n argocd -f confs/app.yaml

echo Waiting for ArgoCD pods to be ready...
sudo kubectl wait pods -n argocd --all --for condition=Ready --timeout=600s
sudo kubectl get pods -n argocd

echo Waiting for app pods to be ready...
sudo kubectl wait pods -n dev --all --for condition=Ready --timeout=600s
sudo kubectl get pods -n dev
