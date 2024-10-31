#!/bin/bash

sudo rm ./argocd_password.txt

sudo k3d cluster delete -a
