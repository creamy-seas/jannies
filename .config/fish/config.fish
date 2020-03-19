bass source ~/.profile

# __  __     _     ____   ____   _____  _____  _____  ___  _   _   ____
#|  \/  |   / \   / ___| / ___| | ____||_   _||_   _||_ _|| \ | | / ___|
#| |\/| |  / _ \ | |     \___ \ |  _|    | |    | |   | | |  \| || |  _
#| |  | | / ___ \| |___   ___) || |___   | |    | |   | | | |\  || |_| |
#|_|  |_|/_/   \_\\____| |____/ |_____|  |_|    |_|  |___||_| \_| \____|
#
#
set PATH /usr/local/bin $PATH
eval (python3 -m virtualfish)
# test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
set VIRTUALFISH_HOME /Users/CCCP/.config/python_vi

abbr jq "jq . /tmp/log"
abbr ranger "ranger --choosedir=$HOME/.rangerdir; cd (cat $HOME/.rangerdir)"

#                      _           _
# _   _   ___   _   _ | |_  _   _ | |__    ___
#| | | | / _ \ | | | || __|| | | || '_ \  / _ \
#| |_| || (_) || |_| || |_ | |_| || |_) ||  __/
# \__, | \___/  \__,_| \__| \__,_||_.__/  \___|
# |___/
#
abbr yt "youtube-dl -f 135+140 -o \"%(title)s.%(ext)s\""
abbr yt134 "youtube-dl -f 134+140 -o \"%(title)s.%(ext)s\""
abbr ytmusic "youtube-dl --embed-thumbnail -f "bestaudio" --extract-audio --audio-format "mp3" -o     \"%(title)s.%(ext)s\""

#           _
# ___  ___ | |__
#/ __|/ __|| '_ \
#\__ \\__ \| | | |
#|___/|___/|_| |_|
#
#
abbr wifigpu "ssh antonov@localhost -p 2410"
abbr gpuextreme "ssh antonov@134.219.128.96 -p 22"
abbr vlad_wifi "ssh vladimirantonov@86.20.96.166 -p 6769"
abbr vlad_wifitunnel "ssh antonov@86.20.96.166 -p 6767"
abbr macmini "ssh ilyaantonov@196.167.0.14 -p 22"
abbr netstat "sudo lsof -i | grep LISTEN"

#                       _
#__      __ __ _   ___ | |_
#\ \ /\ / // _` | / _ \| __|
# \ V  V /| (_| ||  __/| |_
#  \_/\_/  \__, | \___| \__|
#          |___/
#
abbr wg "wget --recursive --page-requisites --html-extension --convert-links --show-progress --no-parent"
abbr wp "wget --page-requisites --html-extension --convert-links --show-progress"
abbr ws "wget --recursive --page-requisites --html-extension --convert-links --show-progress --no-parent"

#                          _
# _   _   __ _  _ __    __| |  ___ __  __
#| | | | / _` || '_ \  / _` | / _ \\ \/ /
#| |_| || (_| || | | || (_| ||  __/ >  <
# \__, | \__,_||_| |_| \__,_| \___|/_/\_\
# |___/
#
abbr yg "cd ~/creamy_seas && ls -dl */ | awk '{print \$9}' | sed \"s|/||\" > ~/creamy_seas/sync_files/yandex_disk/all_folders.txt"

#                    _    __                      _    _
#  ___  ___    ___  | |  / _| _   _  _ __    ___ | |_ (_)  ___   _ __   ___
# / __|/ _ \  / _ \ | | | |_ | | | || '_ \  / __|| __|| | / _ \ | '_ \ / __|
#| (__| (_) || (_) || | |  _|| |_| || | | || (__ | |_ | || (_) || | | |\__ \
# \___|\___/  \___/ |_| |_|   \__,_||_| |_| \___| \__||_| \___/ |_| |_||___/
#
#
abbr google_remove find . -name 'Icon*' -type f -delete
abbr cv_word "convert_word_to_pdf.sh"
abbr gpgr "echo RELOADAGENT | gpg-connect-agent"
abbr se "search_config_files.sh"
abbr mw "move_window.sh"
abbr ss "stream_launch.sh"
abbr ssa "vstream_annotate.sh"
abbr mush "stream_concat.sh"
abbr gbib "get_bibliography.sh"
abbr br "bind_folder_ranger.sh"
abbr rm_bg "remove_background.sh"
abbr go "gource_record.sh"
abbr xc "xcowsay"
abbr sl "sl | lolcat"
abbr yta youtube-dl -f bestaudio --embed-thumbnail --add-metadata -x --audio-format m4a
abbr ytv youtube-dl -f 136+140
# _      ___  _   _  _   _ __  __
#| |    |_ _|| \ | || | | |\ \/ /
#| |     | | |  \| || | | | \  /
#| |___  | | | |\  || |_| | /  \
#|_____||___||_| \_| \___/ /_/\_\
#
#
# abbr sc "sudo systemctl"
# abbr pc "sudo pacman -S"
# abbr emacs "exec emacs"

# set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths
