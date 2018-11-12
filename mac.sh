#!/bin/bash


# Get password
sudo -v


# Command line tools
xcode-select --install


# *** Powerline Fonts ***
./shell/powerline-fonts.sh

# *** Oh-My-Zsh ***
./shell/oh-my-zsh.sh

# *** macOS Settings ***
./mac/settings.sh

# *** Homebrew ***
./mac/brew.sh

# *** CakePHP Plugin ***
./mac/cake.sh

# *** Aliases ***
./aliases/mac.sh


# *** Atom ***
./atom/atom.sh

