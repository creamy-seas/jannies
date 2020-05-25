#!/usr/bin/env bash

#  ____         _         _                   _     _  _       _             __
# |  _ \  _ __ (_) _ __  | |_    ___   _   _ | |_  | |(_) ___ | |_    ___   / _|
# | |_) || '__|| || '_ \ | __|  / _ \ | | | || __| | || |/ __|| __|  / _ \ | |_
# |  __/ | |   | || | | || |_  | (_) || |_| || |_  | || |\__ \| |_  | (_) ||  _|
# |_|    |_|   |_||_| |_| \__|  \___/  \__,_| \__| |_||_||___/ \__|  \___/ |_|
#
#            _             _                                  _  _    _
# __      __(_) _ __    __| |  ___ __      __ ___  __      __(_)| |_ | |__
# \ \ /\ / /| || '_ \  / _` | / _ \\ \ /\ / // __| \ \ /\ / /| || __|| '_ \
#  \ V  V / | || | | || (_| || (_) |\ V  V / \__ \  \ V  V / | || |_ | | | |
#   \_/\_/  |_||_| |_| \__,_| \___/  \_/\_/  |___/   \_/\_/  |_| \__||_| |_|
#
#  ___  ____
# |_ _||  _ \  ___
#  | | | | | |/ __|
#  | | | |_| |\__ \
# |___||____/ |___/
#
#

ALL_SPACES=$(yabai -m query --displays | jq ".[].spaces[]")

for space in $ALL_SPACES; do
    yabai -m query --windows --space $space | jq -r '.[] | (.id|tostring) + " " + (.app|tostring) + " " + (.space|tostring)' > /tmp/window_reporter_buffer.txt
    cat /tmp/window_reporter_buffer.txt
    # echo $(yabai -m query --windows --space $space | jq)
done
