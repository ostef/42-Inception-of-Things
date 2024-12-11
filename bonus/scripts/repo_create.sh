#!/bin/bash

# Make sure we have an up-to-date password
scripts/get_password.sh
REPO=soumanso-IoT
PASSWORD=$(cat gitlab_password.txt)

mkdir app_repo
cd app_repo

git init
git remote add origin http://root:$PASSWORD@localhost:8181/root/$REPO.git

cp ../app_template/* .

git config --local user.name root
git config --local user.password $PASSWORD

git add .
git commit -m "Commit $(date '+%Y-%m-%d %H:%M:%S')"

git push -u origin master

cd ..
rm -rf app_repo
