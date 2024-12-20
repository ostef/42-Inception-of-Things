#!/bin/bash

sudo kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d > argocd_password.txt
sudo kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 -d > gitlab_password.txt

echo -n "ArgoCD: "
cat argocd_password.txt
echo

echo -n "GitLab: "
cat gitlab_password.txt
echo
