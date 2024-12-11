#!/bin/bash

sudo kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d > argocd_password.txt

echo -n "ArgoCD: "
cat argocd_password.txt
echo
