#!/bin/bash


mkdir build_index

cd dolibarr && git tag --sort=-v:refname > ../versions/dolibarrVersions
cd ..

cd versions && split -d -n l/10 dolibarrVersions versions
cd ..
cp template_index/doxygen.css build_index/
cp template_index/tab_b.png build_index/
cp template_index/dolibarr.png build_index/
cat template_index/index-header.html > build_index/index.html

while read version; do
  echo "<li><a href="$version/index.html">$version</a></li>" >> build_index/index.html
done <versions/dolibarrVersions

cat template_index/index-footer.html >> build_index/index.html

