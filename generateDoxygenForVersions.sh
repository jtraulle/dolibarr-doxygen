#!/bin/bash

DIRPATH="$(pwd)"

cd dolibarr && git tag --sort=-v:refname | head -10 > ../versions/dolibarrVersions
cd ..
cd versions && split -d -n l/10 dolibarrVersions versions
cd ..

while read version; do
  echo "Generating Doxygen doc for Dolibarr version $version"
  echo ""

  cd dolibarr
  git checkout -f $version
  cd ${DIRPATH}
  ( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=$version" ; echo "HTML_OUTPUT=$version" ) | doxygen -
done <versions/$VERSIONSFILE

