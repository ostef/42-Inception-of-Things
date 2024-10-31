#!/bin/bash

sudo k3d cluster create bonus

sudo kubectl cluster-info

sudo kubectl create namespace dev
sudo kubectl create namespace argocd
sudo kubectl create namespace gitlab

# Install GitLab
sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update
sudo helm upgrade --install gitlab gitlab/gitlab --namespace gitlab -f ./confs/gitlab.yaml

echo Waiting for GitLab pods to be ready...
sudo kubectl wait pods -n gitlab --all --for condition=available deployments --timeout=600s
sudo kubectl get pods -n gitlab

echo Port forwarding GitLab service to port 8989
sudo kubectl port-forward -n gitlab service/gitlab-webservice-default 8989:8181 &>/dev/null &

# Install ArgoCD
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl apply -n argocd -f confs/app.yaml

echo Waiting for ArgoCD pods to be ready...
sudo kubectl wait pods -n argocd --all --for condition=Ready --timeout=600s
sudo kubectl get pods -n argocd

echo Waiting for app pods to be ready...
sudo kubectl wait pods -n dev --all --for condition=Ready --timeout=600s
sudo kubectl get pods -n dev

echo Port forwarding ArgoCD service to port 9090
sudo kubectl port-forward -n argocd service/argocd-server 9090:443 &>/dev/null &

echo Port forwarding app service to port 8888
sudo kubectl port-forward -n dev service/app-service 8888:8888 &>/dev/null &
