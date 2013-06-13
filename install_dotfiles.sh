#! /bin/bash

# this script assumes that the config files are all contained in a
# directory named "dotfiles" in your home directory

PLATFORM=`uname`

echo "Installing zsh..."
if [ $PLATFORM == 'Darwin' ]; then
    brew install zsh
    grep /usr/local/bin/zsh /etc/shells || sudo echo "/usr/local/bin/zsh" >> /etc/shells
    chsh -s /usr/local/bin/zsh

elif [ $PLATFORM == 'Linux' ] && [ -e /usr/bin/apt-get ]; then
    sudo apt-get install zsh
    grep /usr/bin/zsh /etc/shells || sudo echo "/usr/bin/zsh" >> /etc/shells
    chsh -s /usr/bin/zsh
else
    echo "Unsupported system, please add setup in install_dotfiles.sh"
    exit 1
fi

cd ~

# create symbolic links for config files
for file in ~/dotfiles/.*
do
   ln -s ${file}
done

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

echo "Dotfile setup complete. You may need to log out completely for new settings to take effect"
