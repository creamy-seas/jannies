#!/usr/bin/env bash

# function if_not_application {
#     APPLICATION="$1"

#     if [[ $(evaluate_focused_application.sh) != $APPLICATION ]]; then
#	eval "$2"
#     fi

# }

function move_windows {
    WINDOW_REGEX="$1"
    DESTINATION_SPACE="$2"

    FULL_WINDOW_LIST=$(window_reporter.sh)
    WINDOW_ID_TO_MOVE=$(echo "$FULL_WINDOW_LIST" | egrep "$WINDOW_REGEX" | awk '{print $1}')

    for window_id in $WINDOW_ID_TO_MOVE; do
	yabai -m window $window_id --space "$DESTINATION_SPACE"
    done
}

move_windows "Firefox|Slack|Telegram|Whatsapp|Skype" "messaging"
move_windows "Brave" "browser"
move_windows "Skim" "main"

function sticky_windows {
    WINDOW_REGEX="$1"

    FULL_WINDOW_LIST=$(window_reporter.sh)
    FILTERED_IDS=$(echo "$FULL_WINDOW_LIST" | egrep "$WINDOW_REGEX" | awk '{print $1}')

    for window_id in $FILTERED_IDS; do
	echo $window_id
	yabai -m window $window_id --toggle sticky
    done
}

# sticky_windows "mpv"

# BROWSER_REGEX="Brave"
# BROWSER_IDS=$(window_report.sh | egrep $MESSAGING_REGEX | awk '{print $1}')
