#!/usr/bin/env bash

FILE="$1"
JOBNAME=$(basename "$FILE" | sed 's/\.[^.]*$//')

BUCKET="developai"
BUCKET_PATH="s3://$BUCKET/$JOBNAME"

echo "🐳 Converting '$FILE' to mp3"
ffmpeg -i "$FILE" -y -hide_banner -loglevel panic "$JOBNAME".mp3
FILE="$JOBNAME.mp3"

echo "🐳 Copying over '$FILE' to s3 folder '$BUCKET_PATH'"
aws s3 cp "$FILE" "$BUCKET_PATH/"

echo "🐳 Converting with jobname '$JOBNAME' and dumping to s3 bucket '$BUCKET'"
request_body=$(cat <<EOF
{"MediaFileUri": "$BUCKET_PATH/$FILE"}
EOF
	    )
aws transcribe start-transcription-job\
    --language-code 'en-US'\
    --media-format 'mp3'\
    --transcription-job-name "$JOBNAME"\
    --media "$request_body" \
    --output-bucket-name "$BUCKET"

function probe_status {
    aws transcribe get-transcription-job  --transcription-job-name "$JOBNAME" | jq -r '.TranscriptionJob.TranscriptionJobStatus' 
}
while [[ "COMPLETED" != $(probe_status) ]]; do
    echo "🐢 Waiting for conversion... 2sec"
    sleep 2
done

echo "🐳 Finished conversion -> downloading"
aws s3 mv "s3://$BUCKET/$JOBNAME.json" "$BUCKET_PATH/$JOBNAME.json"
aws s3 cp "$BUCKET_PATH/$JOBNAME.json" /tmp/aws_result.json

echo "🐳 Generating transcript file"
cat /tmp/aws_result.json | jq '.results.transcripts[0].transcript' --raw-output > "$JOBNAME"_transcript.txt

echo "🐋 Finished!"
