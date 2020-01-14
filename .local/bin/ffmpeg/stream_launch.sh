#!/bin/bash

# 0 - go to record folder
folder="/Users/CCCP/mydrive/video_log/example_screencaps"
#folder="/Users/CCCP/gdrive/organizing/ilya_screencap"
cd "$folder"

# 1 - read in -a (audio) tag
if [ $1 = "-a" ];then
    # input device must be soundflower 2ch
    echo "**********Input Device must be soundflower2ch********************";
    read confirm;
    astream_double.sh $2 || echo "No second screen!"\
	    && echo "Record off main? [press Enter]"\
	    && read confirm \
	    && astream_single.sh $2
else
    # 2 - go for the double stream unless second screen is not found
    vstream_double.sh $1 || echo "No second screen!"\
	    && echo "Record off main? [press Enter]"\
	    && read confirm \
	    && vstream_single.sh $1
fi
