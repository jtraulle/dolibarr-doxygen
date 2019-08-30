#!/bin/bash

function bell() {
  while true; do
    echo -e "\a"
    sleep 60
  done
}
bell &

export NODE_OPTIONS=--max_old_space_size=4096

echo -e "\nPushing to Netlify..."
netlify deploy --dir=build --prod

exit $?
