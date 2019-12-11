#!/bin/bash

# 1 - generate filename
name="$(date "+%Y-%m-%d(%a)_$1")"
echo $name

# 2 - generate stream using soundflower audio
ffmpeg -hide_banner\
    -f avfoundation -pix_fmt uyvy422 -i "1" \
    -f avfoundation -i ":1"\
    -filter_complex\
    "color=s=1920x1280:c=black [base];
    [0:v] scale=1920x1200 [mac];
    [1:a] volume=100 [audio];
    [base][mac] overlay=shortest=1:x=0:y=40 [tmp1]"\
	-map [tmp1]\
	-map [audio]\
	-acodec libmp3lame -ab 32k -ac 1\
	-pix_fmt yuv420p\
	-r 30\
	-preset ultrafast\
	$name.mp4

