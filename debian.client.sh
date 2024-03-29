#!/usr/bin/env bash


# *** sudo ***
if [ "$(whoami)" != "root" ] && command -v sudo &> /dev/null; then
  sudo pwd
fi


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


# *** Aliases ***
./shell/debian.aliases.sh


# *** Git ***
source ./git/gitconfig.sh


# *** Default shell ***
chsh -s /usr/bin/zsh

