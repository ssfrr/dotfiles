# source .bashrc (mostly so it gets picked up by screen)
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# Setup SSH Agent

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initializing new SSH agent..."
  /usr/local/bin/ssh-pageant | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo "succeded"
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  #/usr/bin/ssh-add;
}

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep $SSH_PAGEANT_PID | grep ssh-pageant$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi
