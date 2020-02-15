#!/usr/bin/env bash
PATH="$PATH:/usr/local/bin"
BOT_TOKEN='1033566942:AAGQ5pA8t6MK0AsMeAJjFuESh9suLHjzmc8'
BOT_CHATID='-1001235831701'
TEMP_FILE="/tmp/luke_smith"
cd $LUKE_FOLDER
echo "$LUKE_FOLDER" >> /Users/CCCP/cron_log
which youtube-dl >> /Users/CCCP/cron_log
which sed >> /Users/CCCP/cron_log

function telegram_message {
    message=$(sed 's/ /%20/g' <<< $1)
    REQUEST="https://api.telegram.org/bot$BOT_TOKEN/sendMessage?chat_id=$BOT_CHATID&parse_mode=HTML&text=$message"
    curl $REQUEST
}

# Run youtube and not file difference
ls -a | sort > $TEMP_FILE"1"
youtube-dl -i --playlist-end 10 -f 134+140 'https://www.youtube.com/channel/UC2eYFnH61tmytImy1mTYvhA'
ls -a | sort > $TEMP_FILE"2"
comm -1 -3 $TEMP_FILE"1" $TEMP_FILE"2" > $TEMP_FILE
new_files=$(cat $TEMP_FILE | wc -l)

# Iterate through the differences and send to telegram
if [[ new_files -ne 0 ]]; then
    telegram_message "Downloaded <b>$new_files</b> new <b>Boomer</b> videos:"
    while read line; do
	telegram_message "<code>$line</code>"
    done < $TEMP_FILE
fi

rm $TEMP_FILE"1" $TEMP_FILE"2" $TEMP_FILE
