#!/bin/bash

GIT_DEPLOY_REPO=https://${GITHUB_API_KEY}@github.com/jtraulle/dolibarr-doxygen.git

cd build
git init

git config user.name "Deployment Bot"
git config user.email "deploy@travis-ci.org"


for D in `find . -mindepth 1 -type d`
do
    echo "Adding '${D}' folder to git repository..."
    git add ${D}/*
done

git commit -m "Deploy to GitHub Pages"
git push --verbose --progress --force "${GIT_DEPLOY_REPO}" master:gh-pages
