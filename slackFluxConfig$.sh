#!/bin/sh

# curl https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/config-o-matic/slackFluxConfig$.sh | bash

#### set your global config files & variables here:
###$BASHGITVIM="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/bashGitVimNORMAL.sh"

BASHRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bashrc"
BASHPR="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bash_profile"

VIMRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/.vimrc"
FLUXBOXCONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/restoreFluxbox.sh"
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
wget -N $VIMRC -P ~/

## git config
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.pager "less -r"


#### you can use this if you have a file that configures all 3
###curl $BASHGITVIM | bash

curl $FLUXBOXCONF | bash
curl $XFCECONF | bash

if [ ! -z "$( ls /var/log/packages/ | grep pluma )" ]; then
  curl $MATECONF | bash
fi


rm ~/.local/share/applications/userapp-Firefox-*.desktop

echo "Thank you for using config-o-matic!"
echo "P.S. If you are using fluxbox, you should install lxterminal with sbopkg."

