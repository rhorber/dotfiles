#!/bin/bash


# Working directory
if [[ "${PWD##*/}" != "aliases" ]]; then
	cd aliases
fi


# Copy aliases
if [ ! -d "$HOME/.aliases" ]; then
	mkdir $HOME/.aliases
fi
common="$HOME/.aliases/common.sh"
directories="$HOME/.aliases/directories.sh"
lolbash="$HOME/.aliases/lolbash.sh"
funcs="$HOME/.aliases/functions.sh"
cp debian.common.sh $common
cp debian.directories.sh $directories
cp debian.lol.sh $lolbash
cp funcs.sh $funcs


# Bash
cfg="$HOME/.bashrc"
if [[ -z `grep "$common" $cfg` ]]; then
	echo "" >> $cfg
	echo "# Common Aliases" >> $cfg
	echo "source $common" >> $cfg
	echo "" >> $cfg
fi

if [[ -z `grep "$directories" $cfg` ]]; then
	echo "" >> $cfg
	echo "# Directories Aliases" >> $cfg
	echo "source $directories" >> $cfg
	echo "" >> $cfg
fi

if [[ -z `grep "$lolbash" $cfg` ]]; then
	echo "" >> $cfg
	echo "# Lolbash Aliases" >> $cfg
	echo "source $lolbash" >> $cfg
	echo "" >> $cfg
fi

if [[ -z `grep "$funcs" $cfg` ]]; then
	echo "" >> $cfg
	echo "# Grepr Alias" >> $cfg
	echo "source $funcs" >> $cfg
	echo "" >> $cfg
fi

