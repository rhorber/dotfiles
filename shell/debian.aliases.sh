#!/usr/bin/env bash

# Working directory
if [ "${PWD##*/}" != "aliases" ]; then
	cd ../aliases || exit
fi

# Copy aliases
rm "$HOME"/.aliases/*
if [ ! -d "$HOME/.aliases/" ]; then
	mkdir "$HOME/.aliases"
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
            echo "    find ~/.aliases -type f -name '*.sh' -exec bash -c 'source \"\$0\"' {} ';'"
            echo "    find ~/.aliases -type f -name '*.bash' -exec bash -c 'source \"\$0\"' {} ';'"
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
            echo "    find ~/.aliases -type f -name '*.sh' -exec bash -c 'source \"\$0\"' {} ';'"
            echo "    find ~/.aliases -type f -name '*.zsh' -exec bash -c 'source \"\$0\"' {} ';'"
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
    cp ../bin/cp_v8.32.amd64.bin /usr/local/bin/cp
    cp ../bin/mv_v8.32.amd64.bin /usr/local/bin/mv
    chown "$USER": /usr/local/bin/{cp,mv}
    chmod 0755 /usr/local/bin/{cp,mv}
else
    rm ~/.aliases/advanced-coreutils.sh
fi
