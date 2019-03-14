#!/bin/bash


# *** Exeucte actions which require user input at the start ***
# Ask for Git user email
read -p "Enter Git user's email address (leave empty for skipping .gitconfig): " gitUserEmail


# *** inputrc ***
cp ./shell/debian.inputrc ~/.inputrc


# *** Aliases ***
./aliases/debian.sh


# *** vim ***
cp ./vim/common.vim ~/.vimrc


# *** Git ***
./git/gitconfig.sh
