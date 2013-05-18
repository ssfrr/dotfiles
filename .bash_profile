# This is run for login shells (starting an SSH session, for instance). It also
# seems to be run by the cygwin shell

# source our bashrc, so we get all the goodies
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Setup SSH Agent

eval `keychain --eval id_rsa`
