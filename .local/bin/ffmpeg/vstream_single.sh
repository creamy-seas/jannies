#!/bin/bash

# 1 - generate filename
name="$(date "+%Y-%m-%d(%a)_$1")"
echo $name

# 2 - generate stream
ffmpeg -hide_banner\
    -f avfoundation -pix_fmt uyvy422 -i 1 \
    -filter_complex\
    "color=s=1920x1280:c=black [base];
    [0:v] scale=1920x1200 [mac];
    [base][mac] overlay=shortest=1:x=0:y=40"\
	-pix_fmt yuv420p\
	-r 8\
	-preset ultrafast\
	-b:v 1000k\
	$name.mp4
