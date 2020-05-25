# Need to manually install autojump!

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/CCCP/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    #ip ram battery
    dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv
				    status
				    command_execution_time
				    root_indicator
				    background_jobs)

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
	 shrink-path
	 emacs
	 docker
	 autojump
	 brew
	 docker-compose
	 battery
	 zsh-autosuggestions
	 k
	 zsh-syntax-highlighting)
#zsh-syntax-highlighting must be last

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

setopt prompt_subst
PS1='%n@%m $(shrink_path -f)>'
RPROMPT='$(battery_pct_prompt)'


source $ZSH/oh-my-zsh.sh
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# colorize man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESSHISTFILE=-

export CRON_FOLDER="/Users/CCCP/.local/bin/cron"
export EDITOR="emacsclient -t &"	# opening emacs in terminal
export VISUAL="emacsclient"		# open emacs in gui

export HOME=/Users/CCCP
export PATH="$(du $HOME/.local/bin | awk '{print $2}' | tr "\n" ":")/usr/local/bin:~/.cargo/bin:/Library/TeX/texbin:$PATH"

export WORKON_HOME=$HOME/.config/python_vi
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'


source /usr/local/bin/virtualenvwrapper.sh
source ~/.cargo/env


function resolve_cron {

    # Add to crontab
    echo $HH | sudo -S touch /var/log/cron.log 2> /dev/null
    crontab $CRON_FOLDER/ilya_cron


    echo "⏲  Starting cron"
    echo $HH | sudo -S cron 2> /dev/null
}

function resolve_transmission_daemon {
    exists=$(ps aux | grep '[0-9]\{2\} transmission-daemon')

    if [[ -z $exists ]]; then
	transmission-daemon
	echo "✈ Starting \"transmission-daemon\""
    else
	#killall transmission-daemon
	#echo "Killed transmission-daemon"
	echo "✈ \"transmission-daemon\" already up"
    fi
}

resolve_transmission_daemon
resolve_cron

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias se="search_config_files.sh"
alias пше="pshe"
alias gbib="get_bibliography.sh"
alias br="bind_folder_ranger.sh"
alias rbg="remove_background.sh"
alias go="gource_record.sh"
alias zp="zsh_plugin.sh"

# must be here!
source $ZSH/oh-my-zsh.sh
