#!/usr/bin/env bash


# *** inputrc ***
cp ./shell/debian.inputrc ~/.inputrc


# *** Software ***
./bin/packages.sh


# *** Aliases ***
./shell/debian.aliases.sh


# *** vim ***
cp ./vim/vimrc.vim ~/.vimrc

