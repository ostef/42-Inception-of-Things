#!/bin/bash

# Make sure we have an up-to-date password
scripts/get_password.sh
REPO=soumanso-IoT
PASSWORD=$(cat gitlab_password.txt)

if ! git clone http://localhost:8181/root/$REPO.git app_repo;
then
    echo Could not clone repository from GitLab instance
    exit 1
fi

cd app_repo
cp ../app_template/* .

git config --local user.name root
git config --local user.password $PASSWORD

git add .
git commit -m "Commit $(date '+%Y-%m-%d %H:%M:%S')"
git push http://root:$PASSWORD@localhost:8181/root/$REPO.git --all

cd ..
rm -rf app_repo
