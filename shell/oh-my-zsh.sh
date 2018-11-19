#!/bin/bash


# ** Install **
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# ** Config **
cfg="$HOME/.zshrc"
bak="$cfg.bak"
mv $cfg $bak
echo "Configuring the file '$cfg'..."

# add until theme
tmp=`grep -n "^ZSH_THEME=\"" $bak | cut -d: -f1`
let 'foo = tmp - 1'
sed -ne "1,$foo p" $bak >> $cfg

# add new theme
echo "#ZSH_THEME=\"robbyrussell\"" >> $cfg
echo "ZSH_THEME=\"agnoster\"" >> $cfg

# add until plugins
let 'foo = tmp + 1'
tmp=`grep -nE "^plugins=\($" $bak | cut -d: -f1`
sed -ne "$foo,$tmp p" $bak >> $cfg

# set desired plugins
echo "  colored-man-pages" >> $cfg
echo "  git" >> $cfg

# add remainder
tmp=`grep -nE "^)$" $bak | cut -d: -f1`
sed -ne "$tmp,$ p" $bak >> $cfg

