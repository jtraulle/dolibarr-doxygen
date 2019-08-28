#!/bin/bash

echo "Generating Doxygen doc for develop"
echo ""

git clone https://github.com/Dolibarr/dolibarr.git

cd dolibarr
git checkout -f develop
cd ${DIRPATH}
( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=develop" ; echo "HTML_OUTPUT=develop" ) | doxygen -
