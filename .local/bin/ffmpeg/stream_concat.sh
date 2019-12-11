#!/bin/bash

# 1 - iterate through file and create files to concat
for fileName in *.mp4;
do
    echo "file '$fileName'" >> tempFile
done

# 2 - concat
if [ -z $1 ]
then
    ffmpeg -f concat -safe 0 -i tempFile -c copy output.mp4
else
    # name="$(date "+%Y-%m-%d(%a)_$1")"
    name="$1"
    ffmpeg -f concat -safe 0 -i tempFile -c copy "$name.mp4"
fi

# remove empty file
rm -r tempFile
