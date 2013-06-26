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
# set up the PATH
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/BuLogics/codingstandards:$PATH"
export PATH="$HOME/dev/codingstandards:$PATH"
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export EDITOR="vim"
export VISUAL=$EDITOR

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

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
