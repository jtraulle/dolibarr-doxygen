#!/bin/bash

rm -rf build_index build_develop build_versions00 build_versions01 build_versions02 build_versions03 build_versions04 build_versions05 build_versions06 build_versions07 build_versions08 build_versions09
mkdir build_index

cd dolibarr && git tag --sort=-v:refname | head -10 > ../versions/dolibarrVersions
cd ..

cd versions && split -d -n l/10 dolibarrVersions versions
cd ..
cp template_index/doxygen.css build_index/
cp template_index/tab_b.png build_index/
cp template_index/dolibarr.png build_index/
cat template_index/index-header.html > build_index/index.html

echo "<li><a href="develop/index.html">develop</a></li>" >> build_index/index.html

while read version; do
  echo "<li><a href="$version/index.html">$version</a></li>" >> build_index/index.html
done <versions/dolibarrVersions

cat template_index/index-footer.html >> build_index/index.html

