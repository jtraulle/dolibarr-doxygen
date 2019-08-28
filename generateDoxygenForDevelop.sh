#!/bin/bash

DIRPATH="$(pwd)"

echo "Generating Doxygen doc for develop"
echo ""

cd dolibarr
git checkout --quiet -f develop
cd ${DIRPATH}
( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=develop" ; echo "OUTPUT_DIRECTORY=build_develop" ; echo "HTML_OUTPUT=develop" ) | doxygen -
