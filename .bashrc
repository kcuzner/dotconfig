# Base bashrc for new home directories
#
# Kevin Cuzner
#
# !!! IMPORTANT !!!
# Do not modify this file unless making a change that applies to all your
# computers. If it is a local setting (such as appending the .cargo/bin
# folder to your path), use the .bash_local script instead.
#

export EDITOR=vim

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# Extend the path to contain our home folder bin directory
export PATH=$PATH:$HOME/bin

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

COLOR_RESET='\e[0m'

# Use fancy colors if able
case "$(tput colors)" in
    "256" )
        COLOR_ROOT='\e[1;31m'
        COLOR_USER='\e[1;38;5;34m'
        COLOR_SUDO='\e[1;33m'
        COLOR_DIR='\e[1;38;5;33m'
        COLOR_VCS='\e[38;5;202m'
        COLOR_PROMPT='\e[38;5;250m'
        ;;
    *)
        COLOR_ROOT='\e[1;31m'
        COLOR_USER='\e[1;32m'
        COLOR_SUDO='\e[1;33m'
        COLOR_DIR='\e[1;34m'
        COLOR_VCS='\e[33m'
        COLOR_PROMPT=$COLOR_RESET
        ;;
esac

COLOR_CURRENT=${COLOR_USER}

if [[ $EUID -eq 0 ]]; then
    COLOR_CURRENT=${COLOR_ROOT}
elif [[ -n $SUDO_USER ]]; then
    COLOR_CURRENT=${COLOR_SUDO}
fi

prompt_git() {
    git branch &>/dev/null || return 1;
    HEAD="$(git symbolic-ref HEAD 2>/dev/null)";
    BRANCH="${HEAD##refs/heads/}";
    [[ -n "$(git status 2> /dev/null | \
        grep -F 'working tree clean')" ]] || STATUS="!";
    printf '(git:%s)' "${BRANCH:-unknown}${STATUS}";
}
prompt_vcs() {
    printf "$COLOR_VCS ";
    prompt_git;
    printf $COLOR_RESET;
}

PS1="\[$COLOR_CURRENT\]\u@\h\[$COLOR_RESET\]:\[$COLOR_DIR\]\w\[$COLOR_RESET\]\$(prompt_vcs)\n\[$COLOR_PROMPT\]\$ ";

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Execute local machine bash configuration
#
# This will locate the actual position of this bashrc, create a new .bash_local
# in the home directory if able and it doesn't exist and execute ~/.bash_local
# if it exists
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
[[ -f ~/.bash_local ]] || ( [[ -f $DIR/.bash_local ]] && cp $DIR/.bash_local ~/.bash_local && chmod +x ~/.bash_local )
[[ -f ~/.bash_local ]] && . ~/.bash_local

