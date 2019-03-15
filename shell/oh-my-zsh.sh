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
echo "PRIMARY_FG=white" >> $cfg
echo "ZSH_THEME=\"agnoster\"" >> $cfg

# add until plugins
let 'foo = tmp + 1'
tmp=`grep -nE "^plugins=\($" $bak | cut -d: -f1`
sed -ne "$foo,$tmp p" $bak >> $cfg

# set desired plugins
echo "  colored-man-pages" >> $cfg
echo "  git" >> $cfg
echo "  zsh-syntax-highlighting" >> $cfg

# add remainder
tmp=`grep -nE "^)$" $bak | cut -d: -f1`
sed -ne "$tmp,$ p" $bak >> $cfg


# ** Syntax Highlighting Plugin **
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git


# ** Current Agnoster Theme **
cd ~/.oh-my-zsh/custom/themes
git clone https://github.com/agnoster/agnoster-zsh-theme.git
mv agnoster-zsh-theme/agnoster.zsh-theme .
rm -rf agnoster-zsh-theme


# ** Customize Theme **
agnoster="$HOME/.oh-my-zsh/custom/agnoster-customization.zsh"
echo "# Customize agnoster: Remove context and display time" > $agnoster
echo "custom_date () {" >> $agnoster
echo "  prompt_segment \$PRIMARY_FG 'default' \" \`date +'%H:%M:%S'\` \"" >> $agnoster
echo "}" >> $agnoster
echo "" >> $agnoster
echo "AGNOSTER_PROMPT_SEGMENTS[2]=custom_date" >> $agnoster
echo "AGNOSTER_PROMPT_SEGMENTS[3]=" >> $agnoster
echo "" >> $agnoster

echo "" >> $cfg
echo "# Load agnoster customization" >> $cfg
echo "source ${agnoster}" >> $cfg
echo "" >> $cfg
