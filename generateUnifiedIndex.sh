#!/bin/bash

cd dolibarr && git tag --sort=-v:refname | head -10 > ../versions/dolibarrVersions
cd versions && split -d -n l/10 dolibarrVersions versions
cp template_index/doxygen.css build/
cp template_index/tab_b.png build/
cp template_index/dolibarr.png build/
cat template_index/index-header.html > build/index.html

while read version; do
  echo "<li><a href="$version/index.html">$version</a></li>" >> build/index.html
done <versions/dolibarrVersions
