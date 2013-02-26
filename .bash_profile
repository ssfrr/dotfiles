# source .bashrc (mostly so it gets picked up by screen)
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
