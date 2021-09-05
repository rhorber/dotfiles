#!/bin/bash

if [ -z ${gitUserEmail+x} ]; then
  read -p "Enter Git user's email address (leave empty for skipping .gitconfig): " gitUserEmail
fi

if [ "${gitUserEmail}" != "" ]; then
  echo "# This is Git's per-user configuration file." > ~/.gitconfig
  echo "" >> ~/.gitconfig
  echo "[user]" >> ~/.gitconfig
  echo "name = Raphael Horber" >> ~/.gitconfig
  echo "email = ${gitUserEmail}" >> ~/.gitconfig
  echo "" >> ~/.gitconfig
fi

