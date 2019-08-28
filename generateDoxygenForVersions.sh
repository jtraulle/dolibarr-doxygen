#!/bin/bash

DIRPATH="$(pwd)"

cd dolibarr && git tag --sort=-v:refname > ../versions/dolibarrVersions
cd ..
cd versions && split -d -n l/10 dolibarrVersions versions
cd ..

echo "Using version file versions/$VERSIONSFILE"

while read version; do
  echo "Generating Doxygen doc for Dolibarr version $version"
  echo ""

  cd dolibarr
  git checkout --quiet -f $version
  cd ${DIRPATH}
  ( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=$version" ; echo "OUTPUT_DIRECTORY=build_$VERSIONSFILE" ; echo "HTML_OUTPUT=$version" ) | doxygen -
done <versions/$VERSIONSFILE

