#!/bin/bash

gource -s 2 --title "Workflow" -o - --key | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 $1.mp4
