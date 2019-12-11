#!/bin/bash
folder="/Users/CCCP/creamy_seas/2am/google_drive/days_work"

# 1 - generate filename
name="$folder/$(date "+%Y-%m-%d(%a)_$1")"
echo $name

echo "**********Input Device must be soundflower2ch********************";
read confirm;

# 2 - generate stream
ffmpeg -hide_banner\
    -f avfoundation -pix_fmt uyvy422 -i 1\
    -f avfoundation -pix_fmt uyvy422 -i 2\
    -f avfoundation -i ":1"\
    -filter_complex\
    "color=s=2000x1000:c=black [base];
    color=s=606x406:c=cyan [annotation];
		[0:v] scale=600x400 [mac];
		[1:v] scale=2000x1100,crop=in_w:in_h-100 [large];
		[2:a] volume=100 [audio];
		[base][large] overlay=shortest=1 [tmp1];
		[tmp1][annotation] overlay=shortest=1:x=0:y=594 [tmp2];
		[tmp2][mac] overlay=shortest=1:x=3:y=596,drawtext=fontsize=20:fontcolor=white:fontfile=/Users/CCCP/creamy_seas/syncFiles/Inconsolata-Regular.ttf:text='Annotating':x=10:y=580 [tmp3]"\
		    -map [tmp3]\
		    -map [audio]\
		    -acodec libmp3lame -b:a 128k\
		    -pix_fmt yuv420p\
		    -r 20\
		    -preset ultrafast\
		    -b:v 4000k\
		    $name.mp4

# old format at work
# ffmpeg\
#     -f avfoundation -pix_fmt uyvy422 -i 1\
#     -f avfoundation -pix_fmt uyvy422 -i 2\
#     -f avfoundation -i ":1"\
#     -filter_complex\
#     "color=s=2000x1000:c=black [base];
#     color=s=606x406:c=cyan [annotation];
# 		[0:v] scale=600x400 [mac];
# 		[1:v] scale=2000x1100,crop=in_w:in_h-100 [large];
# 		[2:a] volume=100 [audio];
# 		[base][large] overlay=shortest=1 [tmp1];
# 		[tmp1][annotation] overlay=shortest=1:x=0:y=594 [tmp2];
# 		[tmp2][mac] overlay=shortest=1:x=3:y=596,drawtext=fontsize=20:fontcolor=white:fontfile=/Users/CCCP/creamy_seas/syncFiles/Inconsolata-Regular.ttf:text='Annotating':x=10:y=580 [tmp3]"\
# 		    -map [tmp3]\
# 		    -map [audio]\
# 		    -acodec libmp3lame -ab 32k -ac 1\
# 		    -pix_fmt yuv420p\
# 		    -r 20\
# 		    -preset ultrafast\
# 		    -b:v 4000k\
# 		    $name.mp4
