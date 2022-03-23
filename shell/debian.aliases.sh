#!/usr/bin/env bash

# Working directory
if [ "${PWD##*/}" != "aliases" ]; then
  if [ "${PWD##*/}" == "shell" ]; then
    cd ../aliases || exit
  else
    cd aliases || exit
  fi
fi

# Copy aliases
if [ ! -d "$HOME/.aliases/" ]; then
  mkdir "$HOME/.aliases"
else
  rm "$HOME"/.aliases/*
fi
cp ./*.sh "$HOME/.aliases/"

# Bash
if command -v bash &> /dev/null; then
  cp ./*.bash "$HOME/.aliases/"
  if ! grep -F "# Load our aliases" "$HOME/.bashrc" &> /dev/null; then
    {
      echo ""
      echo "# Load our aliases"
      echo "if [ -d ~/.aliases/ ]; then"
      echo "    for f in ~/.aliases/*.sh; do source \"\$f\"; done"
      echo "    for f in ~/.aliases/*.bash; do source \"\$f\"; done"
      echo "fi"
      echo ""
    } >> "$HOME/.bashrc"
  fi
fi

# ZSH
if command -v zsh &> /dev/null; then
  cp ./*.zsh "$HOME/.aliases/"
  if ! grep -F "# Load our aliases" "$HOME/.zshrc" &> /dev/null; then
    {
      echo ""
      echo "# Load our aliases"
      echo "if [ -d ~/.aliases/ ]; then"
      echo "    for f in ~/.aliases/*.sh; do source \"\$f\"; done"
      echo "    for f in ~/.aliases/*.zsh; do source \"\$f\"; done"
      echo "fi"
      echo ""
    } >> "$HOME/.zshrc"
  fi
fi

# Change owner
chown "$USER": "$HOME"/.aliases/*

# Copy binaries
# TODO: Needs sudo...
if [ "$(id -u)" -eq 0 ]; then
  if [ -f "../bin/cp.bin" ]; then
    cp ../bin/cp.bin /usr/local/bin/cp-progress
    chown "$USER": /usr/local/bin/cp-progress
    chmod 0755 /usr/local/bin/cp-progress
  fi

  if [ -f "../bin/mv.bin" ]; then
    cp ../bin/mv.bin /usr/local/bin/mv-progress
    chown "$USER": /usr/local/bin/mv-progress
    chmod 0755 /usr/local/bin/mv-progress
  fi
else
  rm ~/.aliases/advanced-coreutils.sh
fi
