#!/usr/bin/env bash


# ** Install **
if ! command -v git &> /dev/null; then
  if [ "$(whoami)" = "root" ]; then
    SUDO=""
  elif command -v sudo &> /dev/null; then
    SUDO="sudo"
  else
    echo "$(printf '\033[33m')Git is not installed.$(printf '\033[0m') Please install git first."
    exit 1
  fi

  ${SUDO} apt-get -y install git
fi

if [ -d "$HOME/.oh-my-zsh/" ]; then
  (
    cd ~/.oh-my-zsh/ || exit
    git pull
  )
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


# ** Config **
cfg="$HOME/.zshrc"
bak="$cfg.bak"
mv "$cfg" "$bak"
echo "Configuring the file '$cfg'..."

# change theme only if it is outdated
tmp=$(grep -nE "^ZSH_THEME=\"powerlevel10k/powerlevel10k\"" "$bak")
if [ -z "$tmp" ]; then
  # add until theme
  tmp=$(grep -n "^ZSH_THEME=\"" "$bak" | cut -d: -f1)
  foo=$((tmp - 1))

  {
    sed -ne "1,$foo p" "$bak"

    # add new theme
    echo "#ZSH_THEME=\"robbyrussell\""
    echo "POWERLEVEL9K_MODE=\"nerdfont-complete\""
    echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\""
  } >> "$cfg"

  # add from "after theme"
  foo=$((tmp + 1))
else
  # add from the beginning
  foo=1
fi

# add until plugins
tmp=$(grep -nE "^plugins=\($" "$bak" | cut -d: -f1)

if [ "${tmp}" != "" ]; then
  sed -ne "$foo,$tmp p" "$bak" >> "$cfg"

  # calculate remainder (after closing parenthesis)
  tmp=$(grep -nE "^)$" "$bak" | cut -d: -f1)
  tmp=$((tmp + 1))
else
  tmp=$(grep -nE "^plugins=\(" "$bak" | cut -d: -f1)
  tmp=$((tmp - 1))
  sed -ne "$foo,$tmp p" "$bak" >> "$cfg"

  # set desired plugins
  echo "plugins=(" >> "$cfg"

  # calculate remainder
  tmp=$((tmp + 2))
fi

# set desired plugins (replacing existing list)
{
  echo "  colored-man-pages"
  echo "  docker"
  echo "  docker-compose"
  echo "  git"
  echo "  npm"
  echo "  yarn"
  echo "  zsh-autosuggestions"
  echo "  zsh-syntax-highlighting"
  echo ")"
} >> "$cfg"

# add remainder
sed -ne "$tmp,$ p" "$bak" >> "$cfg"

# enable waiting dots
sed -i 's/# COMPLETION_WAITING_DOTS="true"/COMPLETION_WAITING_DOTS="true"/' "$cfg"

# display changes in plugins
echo "The following changes to oh-my-zsh plugins were made (> added, < removed):"
fromPattern="^plugins="
toPattern="^(plugins=\(.*)?\)"
diff=$(
  diff --color=always \
    <(sed -n "$(grep -nE "$fromPattern" "$bak" | cut -d: -f1),$(grep -nP "$toPattern" "$bak" | cut -d: -f1)p" "$bak") \
    <(sed -n "$(grep -nE "$fromPattern" "$cfg" | cut -d: -f1),$(grep -nP "$toPattern" "$cfg" | cut -d: -f1)p" "$cfg")
)
echo "${diff:-"No changes"}"
unset fromPattern toPattern diff


# ** Powerlevel10k Theme **
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k/" ]; then
  (
    cd ~/.oh-my-zsh/custom/themes/powerlevel10k/ || exit
    git pull
  )
else
  (
    cd ~/.oh-my-zsh/custom/themes/ || exit
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
  )
fi

# ** Auto-Suggestions Plugin **
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/" ]; then
  (
    cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/ || exit
    git pull
  )
else
  (
    cd ~/.oh-my-zsh/custom/plugins/ || exit
    git clone https://github.com/zsh-users/zsh-autosuggestions.git
  )
fi

# ** Syntax Highlighting Plugin **
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/" ]; then
  (
    cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/ || exit
    git pull
  )
else
  (
    cd ~/.oh-my-zsh/custom/plugins/ || exit
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  )
fi


# ** Customize Theme **
powerlevel10k="$HOME/.oh-my-zsh/custom/powerlevel10k-customization.zsh"
cat > "$powerlevel10k" << POWERLEVEL10K
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon status time dir dir_writable vcs)
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
