#!/usr/bin/env bash


# Working directory
if [ "${PWD##*/}" != "aliases" ]; then
	cd aliases || exit
fi


# Copy aliases
rm "$HOME"/.aliases/*
if [ ! -d "$HOME/.aliases" ]; then
	mkdir "$HOME/.aliases"
fi
cp ./* "$HOME/.aliases"
chown "$USER": "$HOME"/.aliases/*


# Copy binaries
# TODO: Needs sudo...
if [ -f "../bin/cp.bin" ]; then
    cp ../bin/cp.bin /usr/local/bin/cp
    chown "$USER": /usr/local/bin/cp
    chmod 0755 /usr/local/bin/cp
fi

if [ -f "../bin/mv.bin" ]; then
    cp ../bin/mv.bin /usr/local/bin/mv
    chown "$USER": /usr/local/bin/mv
    chmod 0755 /usr/local/bin/mv
fi


# Bash
if command -v bash &> /dev/null; then
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
