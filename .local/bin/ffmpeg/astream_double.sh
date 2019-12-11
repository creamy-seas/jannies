#!/bin/bash

# 1 - generate filename
name="$(date "+%Y-%m-%d(%a)_$1")"
echo $name

# 2 - generate stream
#ffmpeg -f avfoundation -list_devices true -i ''
ffmpeg -hide_banner\
    -f avfoundation -pix_fmt uyvy422 -i "1"\
    -f avfoundation -pix_fmt uyvy422 -i "2"\
    -f avfoundation -i ":1"\
    -filter_complex\
    "color=s=1980x1280:c=black [base];
    		[0:v] scale=1000x625 [mac];
		[1:v] scale=1680x1050 [large];
		[2:a] volume=100 [audio];
		[base][mac] overlay=shortest=1 [tmp1];
		[tmp1][large] overlay=shortest=1:x=300:y=230 [tmp2]"\
		    -map [tmp2]\
		    -map [audio]\
		    -acodec libmp3lame -ab 32k -ac 1\
		    -pix_fmt yuv420p\
		    -r 30\
		    -preset ultrafast\
		    $name.mp4
