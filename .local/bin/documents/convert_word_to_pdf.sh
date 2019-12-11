#!/bin/bash

printf "\n==> Converting document \"$1\"\n"
save_name=$(echo "$1" | sed "s/\.docx//")

curl -L "https://api.cloudconvert.com/v1/convert" \
     -F "apikey=HxO1K6G4aecpz3zNATkFckYyvLUbPYfs4LkvWzHKnk91Idljev7vOvyKzZ7VDpaG" \
     -F "inputformat=docx" \
     -F "outputformat=pdf" \
     -F "input=upload" \
     -F "timeout=150" \
     -F "wait=true" \
     -F "download=inline" \
     -F "file=@$1" > "$save_name.pdf"
echo "==> Converting finished - created \"$save_name.pdf\""

