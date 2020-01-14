#!/usr/bin/env bash

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
export VISUAL="vim" # open emacs in gui
export BROWSER="firefox"

# export TERMINAL="st"
export SHELL=/usr/local/bin/fish
export HOME=/Users/CCCP
export VIRTUALFISH_HOME=$HOME/creamy_seas/syncFiles/python_vi
export PATH="$(du $HOME/.local/bin | awk '{print $2}' | tr "\n" ":"):$PATH"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
#  ____               _   
# |  _ \  _   _  ___ | |_ 
# | |_) || | | |/ __|| __|
# |  _ < | |_| |\__ \| |_ 
# |_| \_\ \__,_||___/ \__|
#                         
# 
source $HOME/.cargo/env
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
