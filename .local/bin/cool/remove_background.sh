#!/bin/bash

echo "Removing background from $1"
save_name=$(echo "$1" | sed "s/\.png//")

curl -H "X-API-Key:  dvWV6MxDzCpCwTjziM9dNf4H" \
     -F "image_file=@$1" \
     -f https://api.remove.bg/v1.0/removebg -o "$save_name.png"
