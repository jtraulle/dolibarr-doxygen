#!/bin/bash

function bell() {
  while true; do
    echo -e "\a"
    sleep 60
  done
}
bell &

echo -e "\nPushing to Netlify..."
netlify deploy --dir=build

exit $?
