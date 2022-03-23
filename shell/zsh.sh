#!/usr/bin/env bash


# ** Install **
if ! command -v zsh &> /dev/null; then
  if [ "$(whoami)" = "root" ]; then
    SUDO=""
  elif command -v sudo &> /dev/null; then
    SUDO="sudo"
  else
    echo "$(printf '\033[33m')Zsh is not installed.$(printf '\033[0m') Please install zsh first."
    exit 1
  fi

  ${SUDO} apt-get -y install zsh
fi


# Option rmstarsilent
if ! grep -F "rmstarsilent" "$HOME/.zshrc" &> /dev/null; then
  {
    echo ""
    echo "# Custom options"
    echo "setopt rmstarsilent"
    echo ""
  } >> "$HOME/.zshrc"
fi
