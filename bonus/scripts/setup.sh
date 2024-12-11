#!/bin/bash

sudo k3d cluster create bonus

sudo kubectl create namespace dev
sudo kubectl create namespace argocd
sudo kubectl create namespace gitlab

echo Installing GitLab
sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update
sudo helm upgrade --install gitlab gitlab/gitlab \
    --timeout 600s \
    --namespace gitlab \
    --debug \
    --set global.hosts.domain=localhost \
    --set global.hosts.https=false \
    --set global.ingress.configureCertmanager=false \
    --set global.ingress.class=nginx \
    --set certmanager.install=false \
    --set gitlab-runner.install=false

echo Waiting for GitLab to be deployed...
sleep 5
sudo kubectl rollout status deployment gitlab-webservice-default -n gitlab

echo Port forwarding GitLab service to port 8181
sudo kubectl port-forward -n gitlab service/gitlab-webservice-default 8181:8181 &>/dev/null &

read -p "Setup the repository in GitLab under root/app, then press enter to continue."

scripts/setup_app.sh
