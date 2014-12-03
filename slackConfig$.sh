#!/bin/sh

# cd; curl https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/config-o-matic/slackConfig$.sh | sh

### BASHGITVIM="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/bashGitVimNORMAL.sh"

#### set your config files here:

BASHRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bashrc"
BASHPR="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bash_profile"

VIMRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.vimrc"
VIMCOLOR="https://raw.githubusercontent.com/ryanpcmcquen/vim-plain/master/colors/vi-clone.vim"

FLUXBOXCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/restoreFluxbox.sh"

GKRELLCFIL="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/gkrellm2/user-config"
GKRELLTFIL="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/gkrellm2/theme_config"
GKRELLCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/gkrellmConfig.sh"

KDECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/kdeSetup.sh"

XFCECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/xfceSetup.sh"

MATECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/mateSetup.sh"

GITNAME="Ryan P.C. McQuen"
GITEMAIL="ryan.q@linux.com"


if [ ! $UID != 0 ]; then
cat << EOF

This script must not be run as root.

EOF
  exit 1
fi


echo
echo
echo "*************************************************************"
echo "*************************************************************"
echo "********          WELCOME TO                         ********"
echo "********              CONFIG-O-MATIC                 ********"
echo "*************************************************************"
echo "*************************************************************"
echo
echo

## not really necessary, but maybe someday  ;-)
cd

gkrellm &

wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/

wget -N $VIMRC -P ~/
mkdir -p ~/.vim/colors/
wget -N $VIMCOLOR -P ~/.vim/colors/

## git config
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.pager "less -r"

#### you can use this if you have a file that configures all 3
### curl $BASHGITVIM | sh

wget -N $GKRELLCFIL -P ~/.gkrellm2/
wget -N $GKRELLTFIL -P ~/.gkrellm2/
curl $GKRELLCONF | sh

pkill gkrellm &

if [ -d ~/.fluxbox ]; then
  curl $FLUXBOXCONF | sh
fi

if [ -e /var/log/packages/kdelibs-* ]; then
  curl $KDECONF | sh
fi

if [ -e /var/log/packages/pluma-* ]; then
  curl $MATECONF | sh
fi

if [ -e /var/log/packages/Thunar-* ]; then
  curl $XFCECONF | sh
fi

rm ~/.local/share/applications/userapp-Firefox-*.desktop

if [ -e /var/log/packages/superkey-launch-* ]; then
  superkey-launch &
fi


echo
echo
echo "************************************"
echo "********** CONFIG-O-MATIC **********"
echo "************************************"
echo
echo "Thank you for using config-o-matic!"
echo
echo "You should now reboot."
echo

