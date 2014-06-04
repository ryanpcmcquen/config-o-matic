#!/bin/sh

# curl https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/config-o-matic/slackConfig$.sh | bash

#### set your global config files & variables here:
###$BASHGITVIM="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/bashGitVimNORMAL.sh"

BASHRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bashrc"
BASHPR="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bash_profile"

VIMRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/.vimrc"

FLUXBOXCONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/restoreFluxbox.sh"
GKRELLCONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/gkrellmConfig.sh"

XFCECONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/xfceSetup.sh"

MATECONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/mateSetup.sh"


GITNAME="Ryan Q"
GITEMAIL="ryan.q@linux.com"


if [ ! $UID != 0 ]; then
cat << EOF

This script must not be run as root.

EOF
  exit 1
fi


wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/

#mkdir -p ~/.vim/colors/
#wget -N https://raw.githubusercontent.com/flazz/vim-colorschemes/master/colors/c.vim -P ~/.vim/colors
wget -N $VIMRC -P ~/

## git config
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.pager "less -r"


#### you can use this if you have a file that configures all 3
###curl $BASHGITVIM | bash

curl $FLUXBOXCONF | sh
curl $GKRELLCONF | sh
curl $XFCECONF | sh

if [ ! -z "$( ls /var/log/packages/ | grep pluma )" ]; then
  curl $MATECONF | sh
fi


rm ~/.local/share/applications/userapp-Firefox-*.desktop

echo "Thank you for using config-o-matic!"


