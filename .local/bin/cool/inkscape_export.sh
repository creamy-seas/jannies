#!/bin/bash
# 1 - copy over to temp folder
BASENAME=$(sed "s/\..*//" <<< $1)
cp $BASENAME.svg /tmp
TEMPNAME=/tmp/$BASENAME

# 2 - run inkscape export and trim
inkscape --file=$TEMPNAME.svg --export-area-drawing --without-gui --export-png=$TEMPNAME.png 2> /dev/null
convert $TEMPNAME.png -trim $TEMPNAME.png 2> /dev/null

# 3 - copy to original folder
mv $TEMPNAME.png .
rm $TEMPNAME.svg
echo "==> Completed"
