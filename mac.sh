#!/bin/bash


# *** Exeucte actions which require user input at the start ***
# Get password
sudo -v

# Ask for Git user email
read -p "Enter Git user's email address (leave empty for skipping .gitconfig): " gitUserEmail


# Command line tools
xcode-select --install


# *** Powerline Fonts ***
./shell/powerline-fonts.sh

# *** Oh-My-Zsh ***
./shell/oh-my-zsh.sh

# *** Aliases ***
./aliases/mac.sh

# *** vim ***
cp ./vim/common.vim ~/.vimrc
echo "" >> ~/.vimrc
echo "" >> ~/.vimrc
cat ./vim/mac.vim >> ~/.vimrc
echo "" >> ~/.vimrc

# *** Git ***
source ./git/gitconfig.sh


# *** macOS Settings ***
./mac/settings.sh

# *** Homebrew ***
./mac/brew.sh

# *** CakePHP Plugin ***
./mac/cake.sh


# *** Atom ***
./atom/atom.sh

