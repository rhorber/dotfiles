#!/bin/bash

# *** Enable Oh-My-Zsh Plugin ***
cfg="$HOME/.zshrc"
bak="$cfg.cake-bak"

line=`grep -nE "^  cakephp3$" $cfg`
if [[ -z $line ]]; then
	mv $cfg $bak

	tmp=`grep -nE "^plugins=\($" $bak | cut -d: -f1`
	sed -ne "1,$tmp p" $bak >> $cfg

	echo "  cakephp3" >> $cfg

	let 'foo = tmp + 1'
	sed -ne "$foo,$ p" $bak >> $cfg
fi

