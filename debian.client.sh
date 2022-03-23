#!/usr/bin/env bash


# *** Debian Server ***
./debian.server.sh


# *** Vim (additional) ***
{
  echo ""
  cat ./vim/sudo.vim
} >> ~/.vimrc


# *** ZSH ***
./shell/zsh.sh


# *** Oh-My-Zsh ***
./shell/oh-my-zsh.sh


# *** Git ***
source ./git/gitconfig.sh


# *** Default shell ***
chsh -s /usr/bin/zsh

