#!bin/bash

# get video duration
duration_seconds=$(ffprobe -i $1 -show_format | grep duration)
