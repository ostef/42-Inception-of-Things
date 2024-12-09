#!/bin/bash

sudo k3d cluster create p3

sudo kubectl cluster-info

sudo kubectl create namespace dev
sudo kubectl create namespace argocd

echo Applying ArgoCD installation
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo Waiting for ArgoCD pods to be ready...
sudo kubectl wait pods -n argocd --all --for condition=Ready --timeout=600s
sudo kubectl get pods -n argocd

echo Creating app
sudo kubectl port-forward -n argocd svc/argocd-server 8080:80 &

scripts/get_password.sh
ARGOCD_PASSWORD=$(cat argocd_password.txt)

sudo argocd login localhost:8080 --username admin --login $ARGOCD_PASSWORD --insecure
sudo argocd app create playground --repo https://github.com/ostef/soumanso-IoT.git --path . --dest-server https://kubernetes.default.svc --dest-namespace dev
sudo argocd logout

echo Waiting for app pods to be ready...
sudo kubectl wait pods -n dev --all --for condition=Ready --timeout=600s
sudo kubectl get pods -n dev

sudo kubectl port-forward -n dev svc/app-service 8888:8888 &
