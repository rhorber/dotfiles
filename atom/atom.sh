#!/bin/bash

# Working directory
if [[ "${PWD##*}" != "atom" ]]; then
	cd atom
fi


# Copy config
cp config.cson ~/.atom/


# Install packages
apm install atom-beautify
apm install atom-ide-ui
apm install goto-definition
apm install highlight-selected
apm install ide-css
apm install ide-html
apm install ide-json
apm install ide-php
apm install ide-yaml
apm install intellij-idea-keymap
apm install language-ini
apm install minimap
apm install php-twig
apm install simple-drag-drop-text


# Install theme
apm install monokai

