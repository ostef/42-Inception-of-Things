#!/bin/bash

echo Applying ArgoCD installation
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo Waiting for ArgoCD pods to be ready...
sleep 5
sudo kubectl wait pods -n argocd --all --for condition=Ready --timeout=600s

echo Port forwarding ArgoCD service to port 8080
sudo kubectl port-forward -n argocd svc/argocd-server 8080:80 &>/dev/null &

scripts/get_password.sh
ARGOCD_PASSWORD=$(cat argocd_password.txt)
ARGOCD_REPO=http://gitlab-webservice-default.gitlab.svc.cluster.local:8181/root/soumanso-IoT.git/

echo Creating app
sudo argocd login localhost:8080 --username admin --password $ARGOCD_PASSWORD --insecure
sudo argocd app create playground \
    --repo $ARGOCD_REPO --path . \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace dev \
    --self-heal \
    --sync-policy automatic

sudo argocd logout

echo Waiting for app pods to be ready...
sleep 5
sudo kubectl wait pods -n dev --all --for condition=Ready --timeout=600s

echo Port forwarding App service to port 8888
sudo kubectl port-forward -n dev svc/app-service 8888:8888 &>/dev/null &
