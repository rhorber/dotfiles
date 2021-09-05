#!/usr/bin/env bash


# *** Debian Server ***
./debian.server.sh


# *** Vim (additional) ***
{
  echo ""
  cat ./vim/sudo.vim
} >> ~/.vimrc


# *** Oh-My-Zsh ***
./shell/oh-my-zsh.sh


# *** ZSH ***
./shell/zsh.sh


# *** Git ***
source ./git/gitconfig.sh


# *** Default shell ***
chsh -s /usr/bin/zsh

