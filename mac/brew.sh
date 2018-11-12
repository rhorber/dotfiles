#!/bin/bash


# *** Install ***
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

sudo mkdir /usr/local/include
sudo chown -R $(whoami) /usr/local/include


# *** Command line tools ***
brew install tree
brew install htop
brew install node


# *** GUI tools ***
brew cask install iterm2
brew cask install double-commander
brew cask install atom
brew cask install google-chrome
brew cask install firefox
brew cask install spotify
brew cask install vlc
brew cask install jetbrains-toolbox
brew cask install harvest
brew cask install postman


# *** Enable Oh-My-Zsh Plugin ***
cfg="$HOME/.zshrc"
bak="$cfg.brew-bak"

line=`grep -nE "^  brew$" $cfg`
if [[ -z $line ]]; then
	mv $cfg $bak

	tmp=`grep -nE "^plugins=\($" $bak | cut -d: -f1`
	sed -ne "1,$tmp p" $bak >> $cfg

	echo "  brew" >> $cfg

	let 'foo = tmp + 1'
	sed -ne "$foo,$ p" $bak >> $cfg
fi

