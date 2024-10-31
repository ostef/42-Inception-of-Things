#!/bin/bash

sudo rm ./argocd_password.txt
sudo rm ./gitlab_password.txt

sudo k3d cluster delete bonus
