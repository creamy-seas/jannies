if [ "$#" -lt 2 ]; then
    echo "Illegal number of parameters, expecting at least . Usage:"
    echo -e "  $ bash aax2mp3_easy.sh <token> <files_to_be_converted.aax> \n"
    exit 1
fi

TOKEN=$1
FILES=$2

#------------------
# Set-up AAXtoMP3
#------------------
if [ ! -d "AAXtoMP3-master" ]; then
    echo "Downloading AAXtoMP3..."
    brew install wget
    wget https://github.com/KrumpetPirate/AAXtoMP3/archive/master.zip -O aaxtomp3.zip
    unzip aaxtomp3.zip
    rm aaxtomp3.zip

    brew install ffmpeg
    brew install gnu-sed
    brew install grep
    brew install mp4v2
fi


bash AAXtoMP3-master/AAXtoMP3 -A $TOKEN $FILES
