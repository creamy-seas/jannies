#!/usr/bin/env bash

#   ____                __  _
#  / ___| ___   _ __   / _|(_)  __ _
# | |    / _ \ | '_ \ | |_ | | / _` |
# | |___| (_) || | | ||  _|| || (_| |
#  \____|\___/ |_| |_||_|  |_| \__, |
#                              |___/
# __     __            _         _      _
# \ \   / /__ _  _ __ (_)  __ _ | |__  | |  ___  ___
#  \ \ / // _` || '__|| | / _` || '_ \ | | / _ \/ __|
#   \ V /| (_| || |   | || (_| || |_) || ||  __/\__ \
#    \_/  \__,_||_|   |_| \__,_||_.__/ |_| \___||___/
#
#
export LUKE_FOLDER="/Users/CCCP/creamy_seas/boomer/linux"
export CRON_FOLDER="/Users/CCCP/.local/bin/cron"
export HH=d21cyk
export WORKON_HOME="/Users/CCCP/.config/python_vi/"


#  ____   ____    ___   _____  ___  _      _____
# |  _ \ |  _ \  / _ \ |  ___||_ _|| |    | ____|
# | |_) || |_) || | | || |_    | | | |    |  _|
# |  __/ |  _ < | |_| ||  _|   | | | |___ | |___
# |_|    |_| \_\ \___/ |_|    |___||_____||_____|
#
# GPG_TTY=$(tty)
# export GPG_TTY

# 1 - variables to set on login
export EDITOR="emacsclient -t"	# opening emacs in terminal
export VISUAL="emacsclient" # open emacs in gui

# export TERMINAL="st"
export WORKON_HOME=$HOME/.config/python_vi
export SHELL=/usr/local/bin/fish
export HOME=/Users/CCCP
export VIRTUALFISH_HOME=$HOME/.config/python_vi
export PATH="$(du $HOME/.local/bin | awk '{print $2}' | tr "\n" ":"):/usr/local/bin:~/.cargo/bin:$PATH"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

source ~/.cargo/env

#  ____   _                _
# / ___| | |_  __ _  _ __ | |_  _   _  _ __
# \___ \ | __|/ _` || '__|| __|| | | || '_ \
    #  ___) || |_| (_| || |   | |_ | |_| || |_) |
# |____/  \__|\__,_||_|    \__| \__,_|| .__/
#                                     |_|
#
function resolve_transmission_daemon {
    exists=$(ps aux | grep '[0-9]\{2\} transmission-daemon')

    if [[ -z $exists ]]; then
	transmission-daemon
	echo "> Starting \"transmission-daemon\""
    else
	#killall transmission-daemon
	#echo "Killed transmission-daemon"
	echo "> \"transmission-daemon\" already up"
    fi
}

function resolve_cron {

    # Add to crontab
    echo $HH | sudo -S touch /var/log/cron.log 2> /dev/null
    crontab $CRON_FOLDER/ilya_cron


    echo "> Starting cron"
    echo $HH | sudo -S cron 2> /dev/null
}

resolve_transmission_daemon
resolve_cron
