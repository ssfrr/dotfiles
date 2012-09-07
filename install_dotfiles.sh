#! /bin/bash

# this script assumes that the config files are all contained in a
# directory named "dotfiles" in your home directory

# install the ssh-pageant proxy
cp bin/ssh-pageant.exe /usr/local/bin

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
git submodule init
git submodule update

if [ -e ~/.vimrc -o -L ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc.bak; fi
if [ -e ~/.gvimrc -o -L ~/.gvimrc ]; then mv ~/.gvimrc ~/.gvimrc.bak; fi
# init janus
cd .vim
rake
