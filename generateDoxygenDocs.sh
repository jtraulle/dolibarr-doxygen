#!/bin/bash

DIRPATH="$(pwd)"

rm -rf build

if [ ! -d "dolibarr" ]
then
  git clone https://github.com/Dolibarr/dolibarr.git
fi

cd dolibarr
git tag --sort=-v:refname > ../dolibarrVersions.txt
cd ${DIRPATH}

mkdir build
cp template_index/doxygen.css build/
cp template_index/tab_b.png build/
cp template_index/dolibarr.png build/
cat template_index/index-header.html > build/index.html

echo "Generating Doxygen doc for develop"
echo ""  
cd dolibarr
git checkout -f develop
cd ${DIRPATH}
( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=develop" ; echo "HTML_OUTPUT=develop" ) | doxygen -

while read version; do
  echo "Generating Doxygen doc for Dolibarr version $version"
  echo ""
  
  echo "<li><a href="$version/index.html">$version</a></li>" >> build/index.html
  
  cd dolibarr
  git checkout -f $version
  cd ${DIRPATH}
  ( cat dolibarr.doxyfile ; echo "PROJECT_NUMBER=$version" ; echo "HTML_OUTPUT=$version" ) | doxygen -
done <dolibarrVersions.txt

cat template_index/index-footer.html >> build/index.html
