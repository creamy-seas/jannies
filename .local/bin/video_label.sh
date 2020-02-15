#!/usr/bin/env bash

FOLDER_WITH_TIMESTAMPED_FILES=abc

function match_timestamp {
    for file_with_stamp in $FOLDER_WITH_TIMESTAMPED_FILES/*mp4; do
	# 1 - iterate through the folder with timestamped files

	# 2 extract date part and the body to match
	# -n prevents sed from printing every line. /p forces printing of modified linesf
	date=$(sed -n "s|abc/\(([0-9]\{8\})_\).*|\1|p" <<< $file_with_stamp)
	body=$(sed -n "s|abc/([0-9]\{8\})_\(.*\)|\1|p" <<< $file_with_stamp)

	# 3 - remove any non a-z charactes
	body=$(remove_non_alphabet_characters "$body")

	# 4 - match with the inputed file
	if [ "$body" = "$1" ]; then
	    echo $date
	    break
	fi
    done
}

function remove_non_alphabet_characters {
    sed "s|[^a-z()]||g"<<< "$1"
}

for file in *mp4; do
    echo "------------------------------"
    echo $file
    # 1 - remove non a-z characters
    cut_file=$(remove_non_alphabet_characters "$file")

    # 2 - find the date by matching to file in the timestamp folder
    date=$(match_timestamp "$cut_file")

    # 3 - check if there was a match. If yes, rename!
    if [ -z $date ];
    then
	:
    else
	mv "$file" "$date$file"
    fi
done
