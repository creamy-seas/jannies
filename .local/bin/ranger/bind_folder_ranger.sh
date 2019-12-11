#!/bin/bash
# .bak because mac is retarded
# need new line to be posix compliant

RCFILE="/Users/CCCP/.config/ranger/rc.conf" # ranger config file
REGEXP="^map $1 cd .*\$" # regular expression of the form "map gaf cd /Users/ext/dfsda"
REPLACE="map $1 cd $(pwd)"

# 1 - SEARCH for REGEXP
SEARCH=$(cat "$RCFILE" | grep "$REGEXP")

if [ -z "$SEARCH" ]; then
    # 2 - if SEARCH is empty, add a new line after gnuclownworld
    sed -i.bak '/gnuclownworld/a\
    	map '$1' cd '$(pwd)'\
	' "$RCFILE"
    
    echo "Wrote:\
    	 map $1 cd $(pwd)"
else
    # 3 - if keys are already bound, ask before replacing
    echo "Entry already exist:"
    echo "   $SEARCH"
    echo "Replace? [y/N]"
    read confirm
    
    if [ "$confirm" = "y" ];then
	# REPLACE if confimred
	sed -i.bak "s|$REGEXP|$REPLACE|" "$RCFILE"

	echo "Rewrote:\
    		 map $1 cd $(pwd)"
    fi
fi

