#!/usr/bin/env bash


# *** inputrc ***
cp ./shell/debian.inputrc ~/.inputrc


# *** Software ***
./bin/packages.sh


# *** Aliases ***
./shell/debian.aliases.sh


# *** vim ***
cp ./vim/vimrc.vim ~/.vimrc


# *** htop ***
mkdir -p ~/.config/htop
cp ./config/htoprc ~/.config/htop/htoprc

