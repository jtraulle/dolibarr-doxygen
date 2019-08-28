#!/bin/bash

GIT_DEPLOY_REPO=https://${GITHUB_API_KEY}@github.com/jtraulle/dolibarr-doxygen.git

git clone --single-branch --branch gh-pages ${GIT_DEPLOY_REPO} gh-pages

mv build_${VERSIONSFILE}/* gh-pages/

cd gh-pages

git config user.name "Deployment Bot"
git config user.email "deploy@travis-ci.org"

git add .

git commit -m "Deploy to GitHub Pages"
git push --verbose --progress --force "${GIT_DEPLOY_REPO}" gh-pages:gh-pages
