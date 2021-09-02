#!/usr/bin/env bash


# ** Install **
if [ -d "$HOME/.oh-my-zsh/" ]; then
    cd ~/.oh-my-zsh/
    git pull
    cd -
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


# ** Config **
cfg="$HOME/.zshrc"
bak="$cfg.bak"
mv $cfg $bak
echo "Configuring the file '$cfg'..."

# change theme only if it is outdated
tmp=$(grep -nE "^ZSH_THEME='powerlevel10k/powerlevel10k'" $bak)
if [ -z "${tmp}" ]; then
    # add until theme
    tmp=`grep -n "^ZSH_THEME=\"" $bak | cut -d: -f1`
    let 'foo = tmp - 1'
    sed -ne "1,$foo p" $bak >> $cfg

    # add new theme
    echo "#ZSH_THEME=\"robbyrussell\"" >> $cfg
    echo "POWERLEVEL9K_MODE='nerdfont-complete'" >> $cfg
    echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> $cfg

    # add from "after theme"
    let 'foo = tmp + 1'
else
    # add from the beginning
    foo=1
fi

# add until plugins
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

# set desired plugins (replacing existing list)
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

# display changes in plugins
echo "The following changes to oh-my-zsh plugins were made (> added, < removed):"
fromPattern="^plugins="
toPattern="^(plugins=\(.*)?\)"
diff <(sed -n "$(grep -nE $fromPattern $bak | cut -d: -f1),$(grep -nP $toPattern $bak | cut -d: -f1)p" $bak) \
    <(sed -n "$(grep -nE $fromPattern $cfg | cut -d: -f1),$(grep -nP $toPattern $cfg | cut -d: -f1)p" $cfg) \
    --color=always

if [ $? -eq 0 ]; then
    echo "No changes"
fi
unset fromPattern toPattern


# ** Powerlevel10k Theme **
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k/" ]; then
    cd ~/.oh-my-zsh/custom/themes/powerlevel10k/
    git pull
    cd -
else
    cd ~/.oh-my-zsh/custom/themes/
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
    cd -
fi

# ** Auto-Suggestions Plugin **
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/" ]; then
    cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/
    git pull
    cd -
else
    cd ~/.oh-my-zsh/custom/plugins/
    git clone https://github.com/zsh-users/zsh-autosuggestions.git
    cd -
fi

# ** Syntax Highlighting Plugin **
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/" ]; then
    cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
    git pull
    cd -
else
    cd ~/.oh-my-zsh/custom/plugins/
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    cd -
fi


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
