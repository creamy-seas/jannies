#!/bin/bash
BASENAME=$(sed "s/\..*//" <<< $1)
dir=$(pwd)
BASENAME="$(pwd)/$BASENAME"

echo $BASENAME

inkscape --file=$BASENAME".svg" --export-area-drawing --without-gui --export-pdf=$BASENAME".pdf" --export-latex --export-png=$BASENAME"_temp.png" 2> /dev/null

convert $BASENAME"_temp.png" -trim $BASENAME".png" 2> /dev/null
magick $BASENAME".png" -scale 700 $BASENAME"_emacs.png" 2> /dev/null
convert $BASENAME"_temp.png" -trim $BASENAME".png" 2> /dev/null
rm $BASENAME"_temp.png"
echo "==> Completed"
