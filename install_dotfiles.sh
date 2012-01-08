#! /bin/bash

# this script assumes that the config files are all contained in a
# directory named "dotfiles" in your home directory

cd ~

# create symbolic links for config files
for file in ~/dotfiles/.*
do
   ln -s ${file}
done

# remove the link to the .git directory so that our home dir isn't
# seen as versioned
rm ~/.git
