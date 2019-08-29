#!/bin/bash

function bell() {
  while true; do
    echo -e "\a"
    sleep 60
  done
}
bell &

echo -e "\nPushing to surge..."
surge --project ./build --domain dolibarr-doxygen.surge.sh

exit $?
