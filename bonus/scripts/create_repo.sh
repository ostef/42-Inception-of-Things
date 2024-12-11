#!/bin/bash

git clone ssh://git@localhost:8181/root/app.git app_repo
cd app_repo
cp ../app_repo_template/* .
git add .
git commit -m "First commit"
#git push
