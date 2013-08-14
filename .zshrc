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

if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
elif [ -e /usr/bin/virtualenvwrapper.sh ]; then
    source /usr/bin/virtualenvwrapper.sh
else
    echo "virtualenvwrapper not installed"
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

# set up the PATH
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/BuLogics/codingstandards:$PATH"
export PATH="$HOME/dev/codingstandards:$PATH"
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export EDITOR="vim"
export VISUAL=$EDITOR

# set up the ssh agent if necessary
if [ -z $GNOME_KEYRING_CONTROL ]; then
    if command -v keychain >> /dev/null 2>&1; then
        eval `keychain --eval id_rsa`
    else
        echo "keychain is not installed. You're in for some typing"
    fi
fi
