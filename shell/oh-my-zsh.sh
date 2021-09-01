#!/usr/bin/env bash


# ** Install **
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended


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
echo "POWERLEVEL9K_MODE='nerdfont-complete'" >> $cfg
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> $cfg

# add until plugins
let 'foo = tmp + 1'
tmp=`grep -nE "^plugins=\($" $bak | cut -d: -f1`

if [ "${tmp}" != "" ]; then
    sed -ne "$foo,$tmp p" $bak >> $cfg

    # calculate remainder
    tmp=`grep -nE "^)$" $bak | cut -d: -f1`
    let 'tmp = tmp + 1'
else
    tmp=`grep -nE "^plugins=\(" $bak | cut -d: -f1`
    let 'tmp = tmp - 1'
    sed -ne "$foo,$tmp p" $bak >> $cfg

    # set desired plugins
    echo "plugins=(" >> $cfg

    # calculate remainder
    let 'tmp = tmp + 2'
fi

# set desired plugins
echo "  colored-man-pages" >> $cfg
echo "  docker" >> $cfg
echo "  docker-compose" >> $cfg
echo "  git" >> $cfg
echo "  npm" >> $cfg
echo "  yarn" >> $cfg
echo "  zsh-autosuggestions" >> $cfg
echo "  zsh-syntax-highlighting" >> $cfg
echo ")" >> $cfg

# add remainder
sed -ne "$tmp,$ p" $bak >> $cfg

# enable waiting dots
sed -i 's/# COMPLETION_WAITING_DOTS="true"/COMPLETION_WAITING_DOTS="true"/' $cfg


# ** Powerlevel10k Theme **
cd ~/.oh-my-zsh/custom/themes
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git

# ** Auto-Suggestions Plugin **
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git

# ** Syntax Highlighting Plugin **
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git


# ** Customize Theme **
powerlevel10k="$HOME/.oh-my-zsh/custom/powerlevel10k-customization.zsh"
cat > $powerlevel10k << POWERLEVEL10K
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status time dir dir_writable vcs)
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

POWERLEVEL9K_TIME_FOREGROUND='white'
POWERLEVEL9K_TIME_BACKGROUND='236'

POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_ETC_FOREGROUND='226'

POWERLEVEL10K
