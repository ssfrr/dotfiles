#! /bin/bash

# this script assumes that the config files are all contained in a
# directory named "dotfiles" in your home directory

PLATFORM=`uname`

if [ $PLATFORM == 'Darwin' ]; then
    which zsh > /dev/null || (echo "Installing ZSH"; brew install zsh)
    grep /usr/local/bin/zsh /etc/shells || echo "Adding ZSH to shells"; sudo echo "/usr/local/bin/zsh" >> /etc/shells
    chsh -s /usr/local/bin/zsh

elif [ $PLATFORM == 'Linux' ] && which apt-get > /dev/null; then
    # install ZSH if necessary
    which zsh > /dev/null || (echo "Installing ZSH..."; sudo apt-get install zsh)
    grep /usr/bin/zsh /etc/shells > /dev/null || (echo "Adding ZSH to shells";  sudo echo "/usr/bin/zsh" >> /etc/shells)
    grep `whoami` /etc/passwd | grep zsh  > /dev/null || (echo "Changing default shell to ZSH..."; chsh -s /usr/bin/zsh)

elif [ $PLATFORM == 'CYGWIN_NT-6.1-WOW64' ] || [ $PLATFORM == 'CYGWIN_NT-5.1' ]; then
    if command -v zsh >> /dev/null 2>&1; then
        if grep `whoami` /etc/passwd | grep zsh; then
            echo "zsh already set up as shell. good job"
        else
            echo "Please set your shell to zsh by editing /etc/passwd"
            exit -1
        fi
    else
        echo "ZSH not installed, please install with cygwin setup.exe"
        exit -1
    fi
else
    echo "Unsupported system \"$PLATFORM\" please add setup in install_dotfiles.sh"
    exit 1
fi

cd ~

# create symbolic links for config files
for file in ~/dotfiles/.*
do
   ln -s ${file}
done

# make swap directory for vim swapfiles
mkdir ~/.vim/swp

# remove the link to the .git directory so that our home dir isn't
# seen as versioned
rm ~/.git

cd dotfiles
# pull submodules
git submodule update --init

for conffile in zlogin zlogout zprofile zshenv
do
    echo "Linking ${conffile}"
    ln -s ~/.zprezto/runcoms/${conffile} ~/.${conffile}
done

# install atom packages
which apm > /dev/null && \
    apm install --packages-file .atom/packages.txt || \
    echo "apm not found. not installing Atom packages"


echo "Dotfile setup complete. You may need to log out completely for new settings to take effect"
