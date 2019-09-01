#!/bin/bash

DIRPATH="$(pwd)"

while read version; do
  echo "Requiring hschletz/doxygen-phpdoc composer dependency..."
  echo ""
  composer require --prefer-dist hschletz/doxygen-phpdoc

  echo "Generating Doxygen doc for Dolibarr version $version"
  echo ""

  cd dolibarr
  git checkout --quiet -f $version
  cd ${DIRPATH}
  ( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=$version" ; echo "OUTPUT_DIRECTORY=build_versions" ; echo "HTML_OUTPUT=$version" ) | doxygen -
done <versions/dolibarrVersions
