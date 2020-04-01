#!/usr/bin/env bash
PATH="$PATH:/usr/local/bin"
BOT_TOKEN='1033566942:AAGQ5pA8t6MK0AsMeAJjFuESh9suLHjzmc8'
BOT_CHATID='-1001235831701'

YOUTUBE_DL_LINK="$1"
CHANNEL_NAME="$2"
DIRECTORY="$3"
TEMP_FILE="/tmp/"$(sed 's/ /_/g' <<<"$CHANNEL_NAME")

cd "$DIRECTORY"

# Run youtube and note the difference in the files in the directory
ls -a | sort > $TEMP_FILE"1"
youtube-dl -i --playlist-end 20 -f 136+140 "$YOUTUBE_DL_LINK"
ls -a | sort > $TEMP_FILE"2"

# Check for differences
comm -1 -3 $TEMP_FILE"1" $TEMP_FILE"2" > $TEMP_FILE
new_files=$(cat $TEMP_FILE | wc -l)

# Iterate through the differences and send to telegram
function telegram_message {
    message=$(sed 's/ /%20/g' <<< $1)
    REQUEST="https://api.telegram.org/bot$BOT_TOKEN/sendMessage?chat_id=$BOT_CHATID&parse_mode=HTML&text=$message"
    curl $REQUEST
}

if [[ new_files -ne 0 ]]; then
    telegram_message "Downloaded <b>$new_files</b> new <b>$CHANNEL_NAME</b> videos:"
    while read line; do
	telegram_message "<code>$line</code>"
    done < $TEMP_FILE
fi

rm $TEMP_FILE"1" $TEMP_FILE"2" $TEMP_FILE
