#!/bin/bash

rm -rf versions/*
rm -rf build/*

cd dolibarr && git tag --sort=-v:refname | head -10 > ../versions/dolibarrVersions
cd ..

ls -alih

cd versions && split -d -n l/10 dolibarrVersions versions
cp template_index/doxygen.css build/
cp template_index/tab_b.png build/
cp template_index/dolibarr.png build/
cat template_index/index-header.html > build/index.html

echo "<li><a href="develop/index.html">develop</a></li>" >> build/index.html

while read version; do
  echo "<li><a href="$version/index.html">$version</a></li>" >> build/index.html
done <versions/dolibarrVersions

cat template_index/index-footer.html >> build/index.html

