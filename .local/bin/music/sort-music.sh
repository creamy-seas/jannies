#!/usr/bin/env bash

###############################################################################
#  Take current playing song and more it to classical or non-classical folder #
###############################################################################

MUSIC_DB="/Users/CCCP/creamy_seas/db_music"
FOLDER=$1

# Add the "sort" folder to the playlist
# mpc clear > /dev/null
# mpc ls sort | mpc add > /dev/null

# Consume and shuffle every time
# mpc random on > /dev/null
mpc consume on > /dev/null 2>&1
# mpc play > /dev/null

# Get the filename of the song and escape white spaces
CURRENT_FILE=$(mpc status -f "%file%"| head -n 1 | sed 's/ /\ /g')
FULL_PATH="$MUSIC_DB/$CURRENT_FILE"
# echo $FULL_PATH
# echo "----------"

if [[ -f "$FULL_PATH" ]]; then
    if [[ "$FOLDER" == "DELETE" ]]; then
	mv "$FULL_PATH" "$MUSIC_DB/trash" > /dev/null 2>&1
    else
	mkdir "$MUSIC_DB/$FOLDER" > /dev/null 2>&1
	mv "$FULL_PATH" "$MUSIC_DB/$FOLDER" > /dev/null 2>&1
    fi
fi

# Wait until current song finishes
mpc current
