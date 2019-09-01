#!/bin/bash

function bell() {
  while true; do
    echo -e "\a"
    sleep 60
  done
}
bell &

DIRPATH="$(pwd)"

cd versions && split --numeric-suffixes=1 -n l/5 dolibarrVersions versions
cd ..

echo "Using version file versions/$VERSIONSFILE"
echo ""

while read version; do
  echo "Generating Doxygen doc (HTML and LaTeX) for Dolibarr version $version"
  echo ""

  cd dolibarr
  git checkout --quiet -f $version
  cd ${DIRPATH}
  ( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=$version" ; echo "OUTPUT_DIRECTORY=build_$VERSIONSFILE" ; echo "LATEX_OUTPUT=pdf_$version" ; echo "HTML_OUTPUT=$version" ) | doxygen -

  echo "Generating Doxygen PDF doc (from LaTeX using LuaLaTeX) for Dolibarr version $version"
  echo ""
  cd build_$VERSIONSFILE/pdf_$version/
  make
  cd ${DIRPATH}
  mv build_$VERSIONSFILE/pdf_$version/refman.pdf build_$VERSIONSFILE/$version/dolibarr-$version.pdf
done <versions/$VERSIONSFILE
