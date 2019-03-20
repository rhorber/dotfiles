#!/bin/bash


# *** inputrc ***
cp ./shell/debian.inputrc ~/.inputrc


# *** Aliases ***
./aliases/debian.sh


# *** vim ***
cp ./vim/common.vim ~/.vimrc
echo "" >> ~/.vimrc
echo "" >> ~/.vimrc
cat ./vim/debian.vim >> ~/.vimrc
echo "" >> ~/.vimrc

