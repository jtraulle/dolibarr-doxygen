#!/bin/bash

DIRPATH="$(pwd)"

while read version; do
  echo "Generating Doxygen doc for Dolibarr version $version"
  echo ""
  
  echo "<li><a href="$version/index.html">$version</a></li>" >> build/index.html
  
  cd dolibarr
  git checkout -f $version
  cd ${DIRPATH}
  ( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=$version" ; echo "HTML_OUTPUT=$version" ) | doxygen -
done <versions/$VERSIONSFILE

cat template_index/index-footer.html >> build/index.html
