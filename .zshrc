#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#

export WORKON_HOME=$HOME/.virtualenvs

export RED="\e[0;31m"
export YELLOW="\e[0;33m"
export GREEN="\e[0;32m"
export NORMAL="\e[0m"

if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
elif [ -e /usr/bin/virtualenvwrapper.sh ]; then
    source /usr/bin/virtualenvwrapper.sh
else
    echo "${YELLOW}virtualenvwrapper not installed${NORMAL}"
fi

if [ -e /usr/local/bin/hub ] || [ -e /usr/bin/hub ]; then
    alias git=hub
else
    echo "${YELLOW}hub not installed. GitHub will be displeased${NORMAL}"
fi

# set up the PATH
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/BuLogics/codingstandards:$PATH"
export PATH="$HOME/dev/codingstandards:$PATH"
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export EDITOR="vim"
export VISUAL=$EDITOR

alias ijulia="ipython notebook --profile=julia"

# set up the ssh agent if necessary
if [ -z $GNOME_KEYRING_CONTROL ] && [ `uname` != "Darwin" ]; then
    if command -v keychain >> /dev/null 2>&1; then
        eval `keychain --eval id_rsa`
    else
        echo "keychain is not installed. You're in for some typing"
    fi
fi

# source the platform-specific config
case `uname` in
    "Darwin")
        source ~/.zshrc_darwin
        ;;
    "Linux")
        source ~/.zshrc_linux
        ;;
    "CYGWIN_NT-5.1")
        source ~/.zshrc_cygwin
        ;;
esac

# set up some useful aliases

alias gcam='git commit -am'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gps='git push'
alias gpl='git pull'
alias gd='git diff'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ll='ls -la'
alias mkdir='mkdir -pv'

alias j4=julia4
alias j5=julia5

alias v=vim


if [ -e $HOME/.zshrc_local ]; then
    source $HOME/.zshrc_local
else
    echo "${YELLOW}No file $HOME/.zshrc_local found. Feel free to create one${NORMAL}"
fi
