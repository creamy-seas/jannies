#!/bin/bash

# 1 - check for empty input
[ -z "$1" ] && echo "Supply either pdf or dio argument" && exit

# 2 - extract doi name
if [ -f "$1" ]; then
    doi=$(pdfinfo "$1" | grep -io "doi:.*")
    
    if [ -z "$doi" ]; then
	# echo "Extracting directly from pdf"
	# 3 - if pdf info doesn't have the doi tag, then attempt to read pdf
	doi=$(pdftotext "$1" 2> /dev/null - | grep -io -m 1 "doi:.*" | sed "s| ||g")
    fi
else
    # 4 - if file doesn't exist, assume that a doi was passed in
    doi="$1"
fi

# if [ -z $doi ]; then
#     echo "No doi found :(" && exit
# else
#     echo "Found doi:   \"$doi\""
# fi

# 5 - download citation after trimming
# curl "http://api.crossref.org/works/$doi/transform/application/x-bibtex" -w "\\n"
REFFERENCE=$(curl -s "http://api.crossref.org/works/$doi/transform/application/x-bibtex" -w "\\n")

# 6 - confirm write to bib file
echo $REFFERENCE
# echo "Write? [y/N]"
# read confirm
    
# if [ "$confirm" = "y" ];then
    # echo -e $REFFERENCE >> ~/creamy_seas/monday_starts_on_saturday/bibliography.bib && echo "⦿ Copied!"
# elif [ "$confirm" = "N" ]; then
    # echo $REFFERENCE 
# fi
