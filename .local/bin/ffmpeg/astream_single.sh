#!/bin/bash

# 1 - generate filename
name="$(date "+%Y-%m-%d(%a)_$1")"
echo $name

# 2 - generate stream using soundflower audio
#ffmpeg -f avfoundation -list_devices true -i '' # lists the available devices
# 1 - select the audio (:0) and video (1:) sources from those listed above
# 2 - in filter complex use the sources you imported. First imported source is 0 then 1 then 2. Select audio or video to use
ffmpeg -hide_banner\
       -f avfoundation -pix_fmt uyvy422 -i "1"\
       -f avfoundation -i ":0"\
       -filter_complex\
       "color=s=1920x1280:c=black [base]; \
	   [0:v] scale=1920x1200 [mac]; \
	   [1:a] volume=100 [audio]; \
	   [base][mac] overlay=shortest=1:x=0:y=40"\
       -map [audio]\
       -acodec libmp3lame -ab 32k -ac 1\
       -pix_fmt yuv420p\
       -r 30\
       -preset ultrafast\
       $name.mp4
