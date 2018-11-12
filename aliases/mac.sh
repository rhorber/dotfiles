#!/bin/bash


# Working directory
if [[ "${PWD##*/}" != "aliases" ]]; then
	cd aliases
fi


# Copy aliases
if [ ! -d "$HOME/.aliases" ]; then
	mkdir $HOME/.aliases
fi
lolbash="$HOME/.aliases/lolbash.sh"
funcs="$HOME/.aliases/functions.sh"
cp mac.lol.sh $lolbash
cp funcs.sh $funcs


# Bash
cfg="$HOME/.bashrc"
if [[ -e $cfg ]]; then
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
fi


# ZSH
cfg="$HOME/.zshrc"
if [[ -e $cfg ]]; then
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
fi

