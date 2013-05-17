# This is run for login shells (starting an SSH session, for instance). It also
# seems to be run by the cygwin shell

# source our bashrc, so we get all the goodies
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# Setup SSH Agent

eval `keychain --eval id_rsa`
