#!/bin/bash

function bell() {
  while true; do
    echo -e "."
    sleep 60
  done
}
bell &

GIT_DEPLOY_REPO=https://${GITHUB_API_KEY}@github.com/jtraulle/dolibarr-doxygen.git

git config --global gc.auto 0

mkdir gh-pages

mv build/* gh-pages/

cd gh-pages

git init

git config user.name "Deployment Bot"
git config user.email "deploy@travis-ci.org"

git add . > /dev/null

git commit --quiet -m " Deploy jtraulle/dolibarr-doxygen to github.com/jtraulle/dolibarr-doxygen.git:gh-pages"
git push --force "${GIT_DEPLOY_REPO}" master:gh-pages

exit $?
