#!/usr/bin/env bash

###############################################################################
#                             Copy into both files                            #
# Remember that you may need to setup port forwarding for the PI
# Remember to create an account for the PI - it will only be used as a jumpbox and store the id of the remote machine (or there will be man in the middle complaints)
###############################################################################
LOCAL_PORT=6767

PI_FORWARDED_PORT=6767
PI_USERNAME=jumper
PI_ADDRESS=86.20.102.92
PI_PORT=67

REMOTE_PORT=22
REMOTE_ALIVE_INTERVAL=30
REMOTE_ALIVE_MAX_COUNT=9999999

###############################################################################

echo "+----------------------------------+                     +----------------------------------+                  +----------------------------------+"
echo "|         🦑 Local Machine         |                     |           Jumpbox Raspeberry Pi  |                  |          🦅 Remote Machine       |"
echo "+-------------------------------+--+--+               +--+--+----------------------------+--+--+            +--+--+-------------------------------+"
echo "|                               |     |               |     |                            |     |            |     |                               |"
echo "|                               |$LOCAL_PORT----------------->  $PI_PORT ...............................$PI_FORWARDED_PORT ---------------->$REMOTE_PORT"
echo "|                               |     |               |     |                            |     |            |     |                               |"
echo "+-------------------------------+--+--+               +--+--+----------------------------+--+--+            +--+--+-------------------------------+"
echo "🦑 ssh -N -f -L $LOCAL_PORT:localhost:$PI_FORWARDED_PORT $PI_USERNAME@$PI_ADDRESS -p $PI_PORT"
echo "🦅 Run on remote machine                                                                               ssh -f -N -R $PI_FORWARDED_PORT:localhost:$REMOTE_PORT $PI_USERNAME@$PI_ADDRESS -p $PI_PORT"
echo ""
echo ""

echo "All good?"
echo "1) Local machine"
echo "2) Remote machine"
read -p "Select where to launch script from: " SELECTION

# -f go to background
# -N do not execute the actual entry
if [ $SELECTION == 1 ]; then
    echo "🦑 Running on local machine"

    kill $(lsof -i :$LOCAL_PORT | grep TCP | awk '{print $2}' | uniq)

    ssh -f -N \
        -L $LOCAL_PORT:localhost:$PI_FORWARDED_PORT \
        $PI_USERNAME@$PI_ADDRESS -p $PI_PORT

    echo ""
    echo "🦑 Connect with ssh REMOTE-NAME@localhost -p $LOCAL_PORT"

elif [ $SELECTION == 2 ]; then
    echo "🦅 Running the following manually remote machine"
    echo ssh -f -N \
         -o \"ServerAliveInterval $REMOTE_ALIVE_INTERVAL\" -o \"ServerAliveCountMax $REMOTE_ALIVE_MAX_COUNT\" \
         -R $PI_FORWARDED_PORT:localhost:$REMOTE_PORT \
         $PI_USERNAME@$PI_ADDRESS -p $PI_PORT
fi
