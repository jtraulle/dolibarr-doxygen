#!/bin/bash

DIRPATH="$(pwd)"

echo "Generating Doxygen doc for develop"
echo ""

cd dolibarr
git checkout -f develop
cd ${DIRPATH}
( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=develop" ; echo "HTML_OUTPUT=develop" ) | doxygen -
