#!/bin/bash

# 1 - generate filename
name="$(date "+%Y-%m-%d(%a)_$1")"
echo $name

# 2 - generate stream
ffmpeg -hide_banner\
    -f avfoundation -pix_fmt uyvy422 -i 1\
    -f avfoundation -pix_fmt uyvy422 -i 2\
    -filter_complex\
    "color=s=1980x1280:c=black [base];
		[0:v] scale=1000x625 [mac];
		[1:v] scale=1680x1050 [large];
		[base][mac] overlay=shortest=1 [tmp1];
		[tmp1][large] overlay=shortest=1:x=300:y=230"\
	      -pix_fmt yuv420p\
	      -r 10\
	      -preset ultrafast\
	      -b:v 1800k\
	      $name.mp4
