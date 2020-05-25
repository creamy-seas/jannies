#!/bin/bash


LOGIN=$1
PASSWORD=$2

# Check if the number of arguments is equal or greater than 3.
if [ "$#" -lt 2 ]; then
    echo "Illegal number of parameters, expecting at least 2. Usage:"
    echo -e "  $ bash aax2mp3_easy.sh <audible_login> <audible_password>\n"
    exit 1
fi

#--------------------------
# Set-up chrome
#--------------------------
if [ -z $(which chromedriver) ]; then
    echo "Downloading Chrome-Driver-Latest..."
    brew cask install chromedriver
fi
ln -fs `which chromedriver` chromedriver

#--------------------------
# Getting activation code
#--------------------------
ACTIVATION=$(python audible-activator-feature_login_as_arg/audible-activator.py --user $LOGIN --password $PASSWORD | tail -1)
echo "$ACTIVATION"
